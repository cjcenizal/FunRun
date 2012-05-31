package com.funrun.controller.commands {

	import com.funrun.controller.signals.HandleMultiplayerInitRequest;
	import com.funrun.controller.signals.HandleMultiplayerNewPlayerJoinedRequest;
	import com.funrun.controller.signals.HandleMultiplayerPlayerLeftRequest;
	import com.funrun.controller.signals.HandleMultiplayerUpdateRequest;
	import com.funrun.controller.signals.ShowFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.model.UserModel;
	import com.funrun.model.constants.MessageTypes;
	import com.funrun.model.constants.RoomTypes;
	import com.funrun.model.vo.PlayerioErrorVO;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	/**
	 * ConnectMultiplayerCommand displays a "finding game" panel,
	 * and then connects to a room (or gets an error and show feedback).
	 * The room tells us how much time is remaining, and controls the countdown.
	 * When the countdown is up, the room tells us to start the game.
	 */
	public class ConnectMultiplayerCommand extends Command {
		
		// Models.
		
		[Inject]
		public var userModel:UserModel;
		
		// Services.
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		// Commands.
		
		[Inject]
		public var showFindingGamePopupRequest:ShowFindingGamePopupRequest;
		
		[Inject]
		public var showPlayerioErrorPopupRequest:ShowPlayerioErrorPopupRequest;
		
		[Inject]
		public var handleMultiplayerInitRequest:HandleMultiplayerInitRequest;
		
		[Inject]
		public var handleMultiplayerUpdateRequest:HandleMultiplayerUpdateRequest;
		
		[Inject]
		public var handleMultiplayerNewPlayerJoinedRequest:HandleMultiplayerNewPlayerJoinedRequest;
		
		[Inject]
		public var handleMultiplayerPlayerLeftRequest:HandleMultiplayerPlayerLeftRequest;
		
		override public function execute():void {
			// Hide view and block interaction.
			showFindingGamePopupRequest.dispatch();
			// Set up multiplayer.
			multiplayerService.onServerDisconnectSignal.add( onDisconnected );
			multiplayerService.onConnectedSignal.add( onConnected );
			multiplayerService.onErrorSignal.add( onError );
			// One frame delay.
			contextView.stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function onEnterFrame( e:Event ):void {
			contextView.stage.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			// Get a room!
			multiplayerService.connect( loginService.client, RoomTypes.GAME, { name: userModel.name } );
		}
		
		private function onDisconnected():void {
			trace(this, "disconnected");
		}
		
		private function onConnected():void {
			multiplayerService.addMessageHandler( MessageTypes.INIT, onInit );
			multiplayerService.addMessageHandler( MessageTypes.UPDATE, onUpdate );
			multiplayerService.addMessageHandler( MessageTypes.NEW_PLAYER_JOINED, onNewPlayerJoined );
			multiplayerService.addMessageHandler( MessageTypes.PLAYER_LEFT, onPlayerLeft );
		}
		
		private function onError():void {
			showPlayerioErrorPopupRequest.dispatch( new PlayerioErrorVO( multiplayerService.error ) );
		}
		
		private function onInit( message:Message ):void {
			multiplayerService.removeMessageHandler( MessageTypes.INIT, onInit );
			handleMultiplayerInitRequest.dispatch( message );
		}
		
		private function onUpdate( message:Message ):void {
			handleMultiplayerUpdateRequest.dispatch( message );
		}
		
		private function onNewPlayerJoined( message:Message ):void {
			handleMultiplayerNewPlayerJoinedRequest.dispatch( message );
		}
		
		private function onPlayerLeft( message:Message ):void {
			handleMultiplayerPlayerLeftRequest.dispatch( message );
		}
	}
}
