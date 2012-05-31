package com.funrun.controller.commands {

	import com.funrun.controller.signals.HandleMultiplayerJoinGameRequest;
	import com.funrun.controller.signals.ShowFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.controller.signals.StartCountdownRequest;
	import com.funrun.model.constants.MessageTypes;
	import com.funrun.model.constants.RoomTypes;
	import com.funrun.model.vo.PlayerioErrorVO;
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
		
		override public function execute():void {
			// Hide view and block interaction.
			showFindingGamePopupRequest.dispatch();
			// First we need to get matched up with other players.
			matchmakingService.onErrorSignal.add( onError );
			matchmakingService.onConnectedSignal.add( onConnected );
			matchmakingService.connect( loginService.client, RoomTypes.MATCH_MAKING );
		}
		
		private function onConnected():void {
			trace(this, "connected");
			// Listen for disconnect.
			matchmakingService.onServerDisconnectSignal.add( onDisconnected );
			matchmakingService.addMessageHandler( MessageTypes.JOIN_GAME, onJoinGame );
			matchmakingService.addMessageHandler( MessageTypes.START_COUNTDOWN, onStartCountdown );
			matchmakingService.addMessageHandler( MessageTypes.RESET_COUNTDOWN, onResetCountdown );
		}
		
		private function onDisconnected():void {
			trace(this, "disconnected");
			matchmakingService.reset();
		}
		
		private function onError():void {
			trace(this, "error");
			showPlayerioErrorPopupRequest.dispatch( new PlayerioErrorVO( matchmakingService.error ) );
		}
		
		private function onJoinGame( message:Message ):void {
			matchmakingService.removeMessageHandler( MessageTypes.JOIN_GAME, onJoinGame );
			handleMultiplayerJoinGameRequest.dispatch( message );
		}
		
		private function onStartCountdown( message:Message ):void {
			trace("onStartCountdown");
			startCountdownRequest.dispatch( message.getNumber( 0 ) );
		}
		
		private function onResetCountdown( message:Message ):void {
			// Reset the countdown.
			trace("reset");
		}
	}
}
