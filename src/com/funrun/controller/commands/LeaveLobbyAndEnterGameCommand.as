package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.JoinMatchmakingRequest;
	import com.funrun.controller.signals.ResetGameRequest;
	import com.funrun.controller.signals.StartOfflineGameRequest;
	import com.funrun.model.GameModel;
	import com.funrun.model.StateModel;
	import com.funrun.services.LobbyService;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * StartGameCommand starts the main game loop.
	 */
	public class LeaveLobbyAndEnterGameCommand extends Command {
		
		// Services.
		
		[Inject]
		public var lobbyService:LobbyService;
		
		// Models.
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var stateModel:StateModel;
		
		// Commands.
		
		[Inject]
		public var resetGameRequest:ResetGameRequest;
		
		[Inject]
		public var joinMatchmakingRequest:JoinMatchmakingRequest;
		
		[Inject]
		public var startOfflineGameRequest:StartOfflineGameRequest;
		
		override public function execute():void {
			// Disconnect from lobby.
			lobbyService.disconnectAndReset();
			// Reset game.
			resetGameRequest.dispatch();
			// Render to clear the view.
			//renderSceneRequest.dispatch();
			// Connect to a game.
			if ( gameModel.isOnline ) {
				joinMatchmakingRequest.dispatch();
			} else {
				startOfflineGameRequest.dispatch();
			}
		}
	}
}
