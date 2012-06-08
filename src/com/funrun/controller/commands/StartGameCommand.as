package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.InitGameRequest;
	import com.funrun.controller.signals.JoinMatchmakingRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.ResetGameRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.model.GameModel;
	import com.funrun.model.state.GameState;
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
		public var gameModel:GameModel;
		
		// Commands.
		
		[Inject]
		public var resetGameRequest:ResetGameRequest;
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var connectMultiplayerRequest:JoinMatchmakingRequest;
		
		[Inject]
		public var initGameRequest:InitGameRequest;
		
		[Inject]
		public var startRunningRequest:StartRunningRequest;
		
		override public function execute():void {
			// Set game state.
			gameModel.gameState = GameState.WAITING_FOR_PLAYERS;
			// Reset game.
			resetGameRequest.dispatch();
			// Render to clear the view.
			renderSceneRequest.dispatch();
			// Connect to a game.
			if ( onlineState.isOnline ) {
				connectMultiplayerRequest.dispatch();
			} else {
				initGameRequest.dispatch();
				startRunningRequest.dispatch();
			}
		}
	}
}
