package com.funrun.game.controller.commands {
	
	import com.funrun.game.controller.events.AddFloorsRequest;
	import com.funrun.game.controller.events.BuildTimeRequest;
	import com.funrun.game.controller.events.EnablePlayerInputRequest;
	import com.funrun.game.controller.events.RenderSceneRequest;
	import com.funrun.game.controller.events.ResetGameRequest;
	import com.funrun.game.model.constants.TrackConstants;
	import com.funrun.game.model.events.TimeEvent;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * StartGameCommand starts the main game loop.
	 */
	public class StartGameCommand extends Command {
		
		override public function execute():void {
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
