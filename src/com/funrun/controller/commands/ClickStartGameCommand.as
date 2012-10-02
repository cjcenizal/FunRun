package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.JoinMatchmakingRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.ResetGameRequest;
	import com.funrun.controller.signals.StartOfflineGameRequest;
	import com.funrun.model.StateModel;
	import com.funrun.model.state.OnlineState;
	import com.funrun.services.LobbyService;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * StartGameCommand starts the main game loop.
	 */
	public class ClickStartGameCommand extends Command {
		
		// State.
		
		[Inject]
		public var onlineState:OnlineState;
		
		// Services.
		
		[Inject]
		public var lobbyService:LobbyService;
		
		// Models.
		
		[Inject]
		public var stateModel:StateModel;
		
		// Commands.
		
		[Inject]
		public var resetGameRequest:ResetGameRequest;
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var joinMatchmakingRequest:JoinMatchmakingRequest;
		
		[Inject]
		public var startOfflineGameRequest:StartOfflineGameRequest;
		
		override public function execute():void {
			// Disconnect from lobby.
			lobbyService.disconnectAndReset();
			// Set game state.
			stateModel.waitForPlayers();
			// Reset game.
			resetGameRequest.dispatch();
			// Render to clear the view.
			renderSceneRequest.dispatch();
			// Connect to a game.
			if ( onlineState.isOnline ) {
				joinMatchmakingRequest.dispatch();
			} else {
				startOfflineGameRequest.dispatch();
			}
		}
	}
}
