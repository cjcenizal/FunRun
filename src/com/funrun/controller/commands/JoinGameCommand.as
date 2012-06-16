package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.HandleMultiplayerInitRequest;
	import com.funrun.controller.signals.HandleMultiplayerCompetitorJoinedRequest;
	import com.funrun.controller.signals.HandleMultiplayerCompetitorDiedRequest;
	import com.funrun.controller.signals.HandleMultiplayerCompetitorLeftRequest;
	import com.funrun.controller.signals.HandleMultiplayerUpdateRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.MessageTypes;
	import com.funrun.model.constants.RoomTypes;
	import com.funrun.model.vo.PlayerioErrorVO;
	import com.funrun.services.MultiplayerService;
	import com.funrun.services.PlayerioFacebookLoginService;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class JoinGameCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var roomId:String;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Services.
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		[Inject]
		public var multiplayerService:MultiplayerService;
		
		// Commands.
		
		[Inject]
		public var showPlayerioErrorPopupRequest:ShowPlayerioErrorPopupRequest;
		
		[Inject]
		public var handleMultiplayerInitRequest:HandleMultiplayerInitRequest;
		
		[Inject]
		public var handleMultiplayerUpdateRequest:HandleMultiplayerUpdateRequest;
		
		[Inject]
		public var handleMultiplayerCompetitorJoinedRequest:HandleMultiplayerCompetitorJoinedRequest;
		
		[Inject]
		public var handleMultiplayerCompetitorLeftRequest:HandleMultiplayerCompetitorLeftRequest;
		
		[Inject]
		public var handleMultiplayerCompetitorDiedRequest:HandleMultiplayerCompetitorDiedRequest;
		
		override public function execute():void {
			multiplayerService.onErrorSignal.add( onError );
			multiplayerService.onConnectedSignal.add( onConnected );
			multiplayerService.connect( loginService.client, RoomTypes.GAME, { name: playerModel.name, x: playerModel.positionX, y: playerModel.positionY }, roomId );
		}
		
		private function onConnected():void {
			trace(this, "connected");
			multiplayerService.onServerDisconnectSignal.add( onDisconnected );
			multiplayerService.addMessageHandler( MessageTypes.INIT, onInit );
			multiplayerService.addMessageHandler( MessageTypes.UPDATE, onUpdate );
			multiplayerService.addMessageHandler( MessageTypes.NEW_PLAYER_JOINED, onNewPlayerJoined );
			multiplayerService.addMessageHandler( MessageTypes.PLAYER_LEFT, onPlayerLeft );
			multiplayerService.addMessageHandler( MessageTypes.DEATH, onPlayerDied );
		}
		
		private function onDisconnected():void {
			trace(this, "disconnected");
			multiplayerService.reset();
		}
		
		private function onError():void {
			trace(this, "error");
			showPlayerioErrorPopupRequest.dispatch( PlayerioErrorVO( multiplayerService.error ) );
		}
		
		private function onInit( message:Message ):void {
			multiplayerService.removeMessageHandler( MessageTypes.INIT, onInit );
			handleMultiplayerInitRequest.dispatch( message );
		}
		
		private function onUpdate( message:Message ):void {
			handleMultiplayerUpdateRequest.dispatch( message );
		}
		
		private function onNewPlayerJoined( message:Message ):void {
			handleMultiplayerCompetitorJoinedRequest.dispatch( message );
		}
		
		private function onPlayerLeft( message:Message ):void {
			handleMultiplayerCompetitorLeftRequest.dispatch( message );
		}
		
		private function onPlayerDied( message:Message ):void {
			handleMultiplayerCompetitorDiedRequest.dispatch( message );
		}
	}
}
