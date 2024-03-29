package com.funrun.controller.commands {

	import com.funrun.controller.signals.DrawReadyListRequest;
	import com.funrun.controller.signals.JoinGameRequest;
	import com.funrun.controller.signals.LogMessageRequest;
	import com.funrun.controller.signals.ShowLoadingRequest;
	import com.funrun.controller.signals.StartCountdownRequest;
	import com.funrun.controller.signals.UpdateLoadingRequest;
	import com.funrun.controller.signals.vo.LogMessageVo;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.constants.Messages;
	import com.funrun.model.constants.Rooms;
	import com.funrun.services.MatchmakingService;
	import com.funrun.services.PlayerioFacebookLoginService;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	/**
	 * ConnectMultiplayerCommand displays a "finding game" panel,
	 * and then connects to a room (or gets an error and show feedback).
	 * The room tells us how much time is remaining, and controls the countdown.
	 * When the countdown is up, the room tells us to start the game.
	 */
	public class JoinMatchmakingCommand extends Command {
		
		// Services.
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		[Inject]
		public var matchmakingService:MatchmakingService;
		
		// Models.
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var showLoadingRequest:ShowLoadingRequest;
		
		[Inject]
		public var updateLoadingRequest:UpdateLoadingRequest;
		
		[Inject]
		public var startCountdownRequest:StartCountdownRequest;
		
		[Inject]
		public var logMessageRequest:LogMessageRequest;
		
		[Inject]
		public var joinGameRequest:JoinGameRequest;
		
		[Inject]
		public var drawReadyListRequest:DrawReadyListRequest;
		
		override public function execute():void {
			// Hide view and block interaction.
			showLoadingRequest.dispatch( "Finding other players..." );
			// First we need to get matched up with other players.
			matchmakingService.onErrorSignal.add( onError );
			matchmakingService.onConnectedSignal.add( onConnected );
			var userJoinData:Object = { id: loginService.userId };
			matchmakingService.connect( loginService.client, Rooms.MATCH_MAKING, userJoinData );
		}
		
		private function onConnected():void {
			// Listen for disconnect.
			matchmakingService.onServerDisconnectSignal.add( onDisconnected );
			matchmakingService.addMessageHandler( Messages.JOIN_GAME, onJoinGame );
			matchmakingService.addMessageHandler( Messages.READY, onPlayerReady );
			matchmakingService.addMessageHandler( Messages.START_COUNTDOWN, onStartCountdown );
		}
		
		private function onDisconnected():void {
			matchmakingService.reset();
		}
		
		private function onError():void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Error connecting to matchmaking service!" ) );
			updateLoadingRequest.dispatch( matchmakingService.error );
		}
		
		private function onJoinGame( message:Message ):void {
			var roomIdToJoin:String = message.getString( 0 );
			
			logMessageRequest.dispatch( new LogMessageVo( this, "Joined a game, room " + roomIdToJoin ) );
			matchmakingService.removeMessageHandler( Messages.JOIN_GAME, onJoinGame );
			
			// Connect to game.
			joinGameRequest.dispatch( roomIdToJoin );
		}
		
		private function onPlayerReady( message:Message ):void {
			var id:int = message.getInt( 0 );
			if ( competitorsModel.getWithId( id ) ) {
				competitorsModel.getWithId( id ).isReady = true;
				drawReadyListRequest.dispatch();
			}
		}
		
		private function onStartCountdown( message:Message ):void {
			startCountdownRequest.dispatch();
		}
	}
}
