package com.funrun.controller.commands {

	import com.funrun.controller.signals.HandleMultiplayerJoinGameRequest;
	import com.funrun.controller.signals.LogMessageRequest;
	import com.funrun.controller.signals.ResetCountdownRequest;
	import com.funrun.controller.signals.ShowFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.controller.signals.StartCountdownRequest;
	import com.funrun.model.constants.Messages;
	import com.funrun.model.constants.Rooms;
	import com.funrun.model.vo.LogMessageVo;
	import com.funrun.model.vo.PlayerioErrorVo;
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
		
		// Commands.
		
		[Inject]
		public var showFindingGamePopupRequest:ShowFindingGamePopupRequest;
		
		[Inject]
		public var showPlayerioErrorPopupRequest:ShowPlayerioErrorPopupRequest;
		
		[Inject]
		public var handleMultiplayerJoinGameRequest:HandleMultiplayerJoinGameRequest;
		
		[Inject]
		public var startCountdownRequest:StartCountdownRequest;
		
		[Inject]
		public var resetCountdownRequest:ResetCountdownRequest;
		
		[Inject]
		public var logMessageRequest:LogMessageRequest;
		
		override public function execute():void {
			// Hide view and block interaction.
			showFindingGamePopupRequest.dispatch();
			// First we need to get matched up with other players.
			matchmakingService.onErrorSignal.add( onError );
			matchmakingService.onConnectedSignal.add( onConnected );
			matchmakingService.connect( loginService.client, Rooms.MATCH_MAKING );
		}
		
		private function onConnected():void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Connected to matchmaking service." ) );
			// Listen for disconnect.
			matchmakingService.onServerDisconnectSignal.add( onDisconnected );
			matchmakingService.addMessageHandler( Messages.JOIN_GAME, onJoinGame );
			matchmakingService.addMessageHandler( Messages.START_COUNTDOWN, onStartCountdown );
			matchmakingService.addMessageHandler( Messages.RESET_COUNTDOWN, onResetCountdown );
		}
		
		private function onDisconnected():void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Disconnected from matchmaking service." ) );
			matchmakingService.reset();
		}
		
		private function onError():void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Error connecting to matchmaking service." ) );
			showPlayerioErrorPopupRequest.dispatch( new PlayerioErrorVo( matchmakingService.error ) );
		}
		
		private function onJoinGame( message:Message ):void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Joined a game. Message is: " + message ) );
			matchmakingService.removeMessageHandler( Messages.JOIN_GAME, onJoinGame );
			handleMultiplayerJoinGameRequest.dispatch( message );
		}
		
		private function onStartCountdown( message:Message ):void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Started countdown. Message is: " + message ) );
			startCountdownRequest.dispatch( message.getNumber( 0 ) );
		}
		
		private function onResetCountdown( message:Message ):void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Reset countdown. Message is: " + message ) );
			resetCountdownRequest.dispatch();
		}
	}
}
