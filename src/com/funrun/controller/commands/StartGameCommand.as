package com.funrun.controller.commands {
	
	import com.funrun.controller.events.AddFloorsRequest;
	import com.funrun.controller.events.BuildTimeRequest;
	import com.funrun.controller.events.EnablePlayerInputRequest;
	import com.funrun.controller.events.RenderSceneRequest;
	import com.funrun.controller.events.ResetGameRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.GameState;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * StartGameCommand starts the main game loop.
	 */
	public class StartGameCommand extends Command {
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		override public function execute():void {
			// Set game state.
			gameModel.gameState = GameState.WAITING_FOR_PLAYERS;
			// Start countdown.
			countdownModel.start();
			toggleCountdownRequest.dispatch( true );
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			// Respond to input.
			commandMap.mapEvent( KeyboardEvent.KEY_DOWN, KeyDownCommand, KeyboardEvent );
			commandMap.mapEvent( KeyboardEvent.KEY_UP, KeyUpCommand, KeyboardEvent );
			// Reset player.
			eventDispatcher.dispatchEvent( new ResetGameRequest( ResetGameRequest.RESET_GAME_REQUESTED ) );
			// Add initial floor.
			eventDispatcher.dispatchEvent( new AddFloorsRequest( AddFloorsRequest.ADD_FLOORS_REQUESTED, TrackConstants.REMOVE_OBSTACLE_DEPTH, TrackConstants.TRACK_LENGTH, TrackConstants.BLOCK_SIZE ) );
			// Start time.
			eventDispatcher.dispatchEvent( new BuildTimeRequest( BuildTimeRequest.BUILD_TIME_REQUESTED ) );
			// Start input.
			eventDispatcher.dispatchEvent( new EnablePlayerInputRequest( EnablePlayerInputRequest.ENABLE_PLAYER_INPUT_REQUESTED ) );
			// Render to clear the view.
			eventDispatcher.dispatchEvent( new RenderSceneRequest( RenderSceneRequest.RENDER_SCENE_REQUESTED ) );
		}

	}
}
