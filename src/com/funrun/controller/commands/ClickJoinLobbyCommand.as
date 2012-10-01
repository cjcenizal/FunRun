package com.funrun.controller.commands
{
	import com.funrun.controller.signals.HandleLobbyChatRequest;
	import com.funrun.controller.signals.RemoveJoiningLobbyPopupRequest;
	import com.funrun.controller.signals.ShowJoiningLobbyPopupRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.constants.Messages;
	import com.funrun.model.constants.Rooms;
	import com.funrun.model.state.ScreenState;
	import com.funrun.model.vo.PlayerioErrorVo;
	import com.funrun.services.LobbyService;
	import com.funrun.services.PlayerioFacebookLoginService;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;
	
	/**
	 * Connect to lobby service.
	 */
	public class ClickJoinLobbyCommand extends Command
	{
		
		// Services.
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		[Inject]
		public var lobbyService:LobbyService;
		
		// Commands.
		
		[Inject]
		public var showJoiningLobbyPopupRequest:ShowJoiningLobbyPopupRequest;
		
		[Inject]
		public var showPlayerioErrorPopupRequest:ShowPlayerioErrorPopupRequest;
		
		[Inject]
		public var handleLobbyChatRequest:HandleLobbyChatRequest;
		
		[Inject]
		public var removeJoiningLobbyPopupRequest:RemoveJoiningLobbyPopupRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function execute():void
		{
			// Hide view and block interaction.
			showJoiningLobbyPopupRequest.dispatch();
			// Join the lobby.
			lobbyService.onErrorSignal.add( onError );
			lobbyService.onConnectedSignal.add( onConnected );
			lobbyService.connect( loginService.client, Rooms.LOBBY );
		}
		
		private function onConnected():void {
			// Listen for disconnect.
			lobbyService.onServerDisconnectSignal.add( onDisconnected );
			lobbyService.addMessageHandler( Messages.CHAT, onChat );
			// Show lobby.
			removeJoiningLobbyPopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.LOBBY );
		}
		
		private function onDisconnected():void {
			lobbyService.reset();
		}
		
		private function onError():void {
			showPlayerioErrorPopupRequest.dispatch( new PlayerioErrorVo( lobbyService.error ) );
		}
		
		private function onChat( message:Message ):void {
			handleLobbyChatRequest.dispatch( message );
		}
	}
}