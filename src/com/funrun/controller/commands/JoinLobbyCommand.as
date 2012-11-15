package com.funrun.controller.commands
{
	import com.funrun.controller.signals.HandleLobbyChatRequest;
	import com.funrun.controller.signals.HandleLobbyPlayerJoinedRequest;
	import com.funrun.controller.signals.HandleLobbyPlayerLeftRequest;
	import com.funrun.controller.signals.HandleLobbyWelcomeRequest;
	import com.funrun.controller.signals.HideLoadingRequest;
	import com.funrun.controller.signals.LeaveLobbyAndEnterGameRequest;
	import com.funrun.controller.signals.ShowLoadingRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.UpdateLoadingRequest;
	import com.funrun.model.GameModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Messages;
	import com.funrun.model.constants.Rooms;
	import com.funrun.model.constants.Screen;
	import com.funrun.services.LobbyService;
	import com.funrun.services.PlayerioFacebookLoginService;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;
	
	/**
	 * Connect to lobby service.
	 */
	public class JoinLobbyCommand extends Command
	{
		
		// State.
		
		[Inject]
		public var gameModel:GameModel;
		
		// Services.
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		[Inject]
		public var lobbyService:LobbyService;
		
		// Model.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var clickStartGameRequest:LeaveLobbyAndEnterGameRequest;
		
		[Inject]
		public var showLoadingRequest:ShowLoadingRequest;
		
		[Inject]
		public var updateLoadingRequest:UpdateLoadingRequest;
		
		[Inject]
		public var handleLobbyChatRequest:HandleLobbyChatRequest;
		
		[Inject]
		public var handleLobbyPlayerLeftRequest:HandleLobbyPlayerLeftRequest;
		
		[Inject]
		public var handleLobbyPlayerJoinedRequest:HandleLobbyPlayerJoinedRequest;
		
		[Inject]
		public var handleLobbyWelcomeRequest:HandleLobbyWelcomeRequest;
		
		[Inject]
		public var hideLoadingRequest:HideLoadingRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function execute():void
		{
			if ( gameModel.isOnline && !gameModel.isExploration ) {
				// Hide view and block interaction.
				showLoadingRequest.dispatch( "Joining lobby..." );
				// Join the lobby.
				lobbyService.onErrorSignal.add( onError );
				lobbyService.onConnectedSignal.add( onConnected );
				var userJoinData:Object = {
					name: playerModel.name,
					id: loginService.userId };
				lobbyService.connect( loginService.client, Rooms.LOBBY, userJoinData );
			} else {
				// Stubbed offline behavior is to just start a game.
				clickStartGameRequest.dispatch();
			}
		}
		
		private function onConnected():void {
			// Listen for disconnect.
			lobbyService.onServerDisconnectSignal.add( onDisconnected );
			lobbyService.addMessageHandler( Messages.CHAT, onChat );
			lobbyService.addMessageHandler( Messages.JOIN, onJoin );
			lobbyService.addMessageHandler( Messages.LEAVE, onLeave );
			lobbyService.addMessageHandler( Messages.WELCOME, onWelcome );
			// Show lobby.
			hideLoadingRequest.dispatch();
			showScreenRequest.dispatch( Screen.LOBBY );
		}
		
		private function onDisconnected():void {
			lobbyService.reset();
		}
		
		private function onError():void {
			updateLoadingRequest.dispatch( lobbyService.error );
		}
		
		private function onChat( message:Message ):void {
			handleLobbyChatRequest.dispatch( message );
		}
		
		private function onJoin( message:Message ):void {
			handleLobbyPlayerJoinedRequest.dispatch( message );
		}
		
		private function onLeave( message:Message ):void {
			handleLobbyPlayerLeftRequest.dispatch( message );
		}
		
		private function onWelcome( message:Message ):void {
			handleLobbyWelcomeRequest.dispatch( message );
		}
	}
}