package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddFloorRequest;
	import com.funrun.controller.signals.ConnectMultiplayerRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.ResetGameRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.payload.AddFloorPayload;
	import com.funrun.model.GameModel;
	import com.funrun.model.state.GameState;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.state.ScreenState;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * StartGameCommand starts the main game loop.
	 */
	public class StartGameCommand extends Command {
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		[Inject]
		public var resetGameRequest:ResetGameRequest;
		
		[Inject]
		public var addFloorRequest:AddFloorRequest;
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var connectMultiplayerRequest:ConnectMultiplayerRequest;
		
		override public function execute():void {
			// Show game screen.
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
			// Set game state.
			gameModel.gameState = GameState.WAITING_FOR_PLAYERS;
			// Reset game.
			resetGameRequest.dispatch();
			// Add initial floor.
			addFloorRequest.dispatch( new AddFloorPayload( TrackConstants.REMOVE_OBSTACLE_DEPTH, TrackConstants.TRACK_LENGTH, TrackConstants.BLOCK_SIZE ) );
			// Render to clear the view.
			renderSceneRequest.dispatch();
			// Connect to a game.
			connectMultiplayerRequest.dispatch();
		}
	}
}
