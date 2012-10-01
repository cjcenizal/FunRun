package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.HandleMultiplayerCompetitorDiedRequest;
	import com.funrun.controller.signals.HandleMultiplayerCompetitorJoinedRequest;
	import com.funrun.controller.signals.HandleMultiplayerCompetitorLeftRequest;
	import com.funrun.controller.signals.HandleMultiplayerInitRequest;
	import com.funrun.controller.signals.HandleMultiplayerUpdateRequest;
	import com.funrun.controller.signals.LogMessageRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.controller.signals.vo.LogMessageVo;
	import com.funrun.controller.signals.vo.PlayerioErrorVo;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Messages;
	import com.funrun.model.constants.Rooms;
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
		
		[Inject]
		public var logMessageRequest:LogMessageRequest;
		
		override public function execute():void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Joining a game..." ) );
			multiplayerService.onErrorSignal.add( onError );
			multiplayerService.onConnectedSignal.add( onConnected );
			var userJoinData:Object = {
				name: playerModel.name,
				id: loginService.userId,
				x: playerModel.position.x,
				y: playerModel.position.y };
			multiplayerService.connect( loginService.client, Rooms.GAME, userJoinData, roomId );
		}
		
		private function onConnected():void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Connected to game." ) );
			multiplayerService.onServerDisconnectSignal.add( onDisconnected );
			multiplayerService.addMessageHandler( Messages.INIT, onInit );
			multiplayerService.addMessageHandler( Messages.UPDATE, onUpdate );
			multiplayerService.addMessageHandler( Messages.NEW_PLAYER_JOINED, onNewPlayerJoined );
			multiplayerService.addMessageHandler( Messages.PLAYER_LEFT, onPlayerLeft );
			multiplayerService.addMessageHandler( Messages.DEATH, onPlayerDied );
		}
		
		private function onDisconnected():void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Disconnected from game." ) );
			multiplayerService.reset();
		}
		
		private function onError():void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Error connecting to game." ) );
			showPlayerioErrorPopupRequest.dispatch( PlayerioErrorVo( multiplayerService.error ) );
		}
		
		private function onInit( message:Message ):void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Game init. Message is: " + message ) );
			multiplayerService.removeMessageHandler( Messages.INIT, onInit );
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
