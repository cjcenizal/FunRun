package com.funrun.game.controller.commands {
	
	import com.funrun.game.controller.events.AddFloorsRequest;
	import com.funrun.game.controller.events.BuildTimeRequest;
	import com.funrun.game.controller.events.EnablePlayerInputRequest;
	import com.funrun.game.controller.events.RemoveObjectFromSceneRequest;
	import com.funrun.game.controller.events.RenderSceneRequest;
	import com.funrun.game.controller.events.StartRunningGameRequest;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.FloorsModel;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.TrackModel;
	import com.funrun.game.model.constants.TrackConstants;
	import com.funrun.game.model.events.TimeEvent;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * StartGameCommand starts the main game loop.
	 */
	public class StartGameCommand extends Command {

		[Inject]
		public var floorsModel:FloorsModel;

		[Inject]
		public var trackModel:TrackModel;

		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var cameraModel:CameraModel;
		
		override public function execute():void {
			// Resurrect plater.
			// TO-DO: Issue a ResetPlayerRequest.
			playerModel.isDead = false;
			// Reset player and camera position.
			playerModel.player.x = cameraModel.x = 0;
			cameraModel.y = 0;
			cameraModel.update();
			// Remove any old obstacles.
			while ( trackModel.numObstacles > 0 ) {
				var removeEvent:RemoveObjectFromSceneRequest = new RemoveObjectFromSceneRequest( RemoveObjectFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED, trackModel.getObstacleAt( 0 ).mesh );
				eventDispatcher.dispatchEvent( removeEvent );
				trackModel.removeObstacleAt( 0 );
			}
			// Add initial floor.
			eventDispatcher.dispatchEvent( new AddFloorsRequest( AddFloorsRequest.ADD_FLOORS_REQUESTED, TrackConstants.REMOVE_OBSTACLE_DEPTH, TrackConstants.TRACK_LENGTH, TrackConstants.BLOCK_SIZE ));
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			// Respond to input.
			commandMap.mapEvent( KeyboardEvent.KEY_DOWN, KeyDownCommand, KeyboardEvent );
			commandMap.mapEvent( KeyboardEvent.KEY_UP, KeyUpCommand, KeyboardEvent );
			// Start time.
			eventDispatcher.dispatchEvent( new BuildTimeRequest( BuildTimeRequest.BUILD_TIME_REQUESTED ) );
			// Start input.
			eventDispatcher.dispatchEvent( new EnablePlayerInputRequest( EnablePlayerInputRequest.ENABLE_PLAYER_INPUT_REQUESTED ) );
			// Start running.
			eventDispatcher.dispatchEvent( new StartRunningGameRequest( StartRunningGameRequest.START_RUNNING_GAME_REQUESTED ) );
			
			// Render to clear the view.
			eventDispatcher.dispatchEvent( new RenderSceneRequest( RenderSceneRequest.RENDER_SCENE_REQUESTED ) );
		}

	}
}
