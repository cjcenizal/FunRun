package com.funrun.game.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funrun.game.controller.events.AddFloorsRequest;
	import com.funrun.game.controller.events.AddObjectToSceneRequest;
	import com.funrun.game.controller.events.BuildTimeRequest;
	import com.funrun.game.controller.events.EnablePlayerInputRequest;
	import com.funrun.game.model.FloorsModel;
	import com.funrun.game.model.TrackModel;
	import com.funrun.game.model.constants.FloorTypes;
	import com.funrun.game.model.constants.TrackConstants;
	import com.funrun.game.model.data.ObstacleData;
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
		
		override public function execute():void {
			// Add initial floor.
			eventDispatcher.dispatchEvent( new AddFloorsRequest( AddFloorsRequest.ADD_FLOORS_REQUESTED, 0, TrackConstants.TRACK_LENGTH, TrackConstants.BLOCK_SIZE ) );
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			// Respond to input.
			commandMap.mapEvent( KeyboardEvent.KEY_DOWN, KeyDownCommand, KeyboardEvent );
			commandMap.mapEvent( KeyboardEvent.KEY_UP, KeyUpCommand, KeyboardEvent );
			// Start time.
			eventDispatcher.dispatchEvent( new BuildTimeRequest( BuildTimeRequest.BUILD_TIME_REQUESTED ) );
			// Start input.
			eventDispatcher.dispatchEvent( new EnablePlayerInputRequest( EnablePlayerInputRequest.ENABLE_PLAYER_INPUT_REQUESTED ) );
		}
		
	}
}