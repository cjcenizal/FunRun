package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.JoinMatchmakingRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.ResetGameRequest;
	import com.funrun.controller.signals.StartOfflineGameRequest;
	import com.funrun.model.StateModel;
	import com.funrun.model.state.OnlineState;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * StartGameCommand starts the main game loop.
	 */
	public class StartGameCommand extends Command {
		
		// State.
		
		[Inject]
		public var onlineState:OnlineState;
		
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
