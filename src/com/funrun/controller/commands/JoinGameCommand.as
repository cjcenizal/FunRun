package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.HandleGameCompetitorDiedRequest;
	import com.funrun.controller.signals.HandleGameCompetitorJoinedRequest;
	import com.funrun.controller.signals.HandleGameCompetitorLeftRequest;
	import com.funrun.controller.signals.HandleGameInitRequest;
	import com.funrun.controller.signals.HandleGameUpdateRequest;
	import com.funrun.controller.signals.LogMessageRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.controller.signals.vo.LogMessageVo;
	import com.funrun.controller.signals.vo.PlayerioErrorVo;
	import com.funrun.model.GameModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Messages;
	import com.funrun.model.constants.Rooms;
	import com.funrun.services.GameService;
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
		public var gameService:GameService;
		
		[Inject]
		public var gameModel:GameModel;
		
		// Commands.
		
		[Inject]
		public var showPlayerioErrorPopupRequest:ShowPlayerioErrorPopupRequest;
		
		[Inject]
		public var handleGameInitRequest:HandleGameInitRequest;
		
		[Inject]
		public var handleGameUpdateRequest:HandleGameUpdateRequest;
		
		[Inject]
		public var handleGameCompetitorJoinedRequest:HandleGameCompetitorJoinedRequest;
		
		[Inject]
		public var handleGameCompetitorLeftRequest:HandleGameCompetitorLeftRequest;
		
		[Inject]
		public var handleGameCompetitorDiedRequest:HandleGameCompetitorDiedRequest;
		
		[Inject]
		public var logMessageRequest:LogMessageRequest;
		
		override public function execute():void {
			gameModel.isMultiplayer = true;
			gameService.onErrorSignal.add( onError );
			gameService.onConnectedSignal.add( onConnected );
			var userJoinData:Object = {
				name: playerModel.name,
				id: loginService.userId,
				x: playerModel.position.x,
				y: playerModel.position.y,
				char: playerModel.characterId };
			gameService.connect( loginService.client, Rooms.GAME, userJoinData, roomId );
		}
		
		private function onConnected():void {
			gameService.onServerDisconnectSignal.add( onDisconnected );
			gameService.addMessageHandler( Messages.INIT, onInit );
			gameService.addMessageHandler( Messages.UPDATE, onUpdate );
			gameService.addMessageHandler( Messages.NEW_PLAYER_JOINED, onNewPlayerJoined );
			gameService.addMessageHandler( Messages.PLAYER_LEFT, onPlayerLeft );
			gameService.addMessageHandler( Messages.DEATH, onPlayerDied );
		}
		
		private function onDisconnected():void {
			gameService.reset();
		}
		
		private function onError():void {
			logMessageRequest.dispatch( new LogMessageVo( this, "Error connecting to game." ) );
			showPlayerioErrorPopupRequest.dispatch( PlayerioErrorVo( gameService.error ) );
		}
		
		private function onInit( message:Message ):void {
			gameService.removeMessageHandler( Messages.INIT, onInit );
			handleGameInitRequest.dispatch( message );
		}
		
		private function onUpdate( message:Message ):void {
			handleGameUpdateRequest.dispatch( message );
		}
		
		private function onNewPlayerJoined( message:Message ):void {
			handleGameCompetitorJoinedRequest.dispatch( message );
		}
		
		private function onPlayerLeft( message:Message ):void {
			handleGameCompetitorLeftRequest.dispatch( message );
		}
		
		private function onPlayerDied( message:Message ):void {
			handleGameCompetitorDiedRequest.dispatch( message );
		}
	}
}
