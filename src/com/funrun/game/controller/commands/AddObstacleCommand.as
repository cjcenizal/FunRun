package com.funrun.game.controller.commands {
	
	import away3d.entities.Mesh;
	
	import com.funrun.game.controller.events.AddObjectToSceneRequest;
	import com.funrun.game.model.Constants;
	import com.funrun.game.model.FloorsModel;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.model.TrackModel;
	
	import org.robotlegs.mvcs.Command;

	public class AddObstacleCommand extends Command {
		
		[Inject]
		public var obstaclesModel:ObstaclesModel;
		
		[Inject]
		public var floorsModel:FloorsModel;
		
		[Inject]
		public var trackModel:TrackModel;

		override public function execute():void {
			// Get an obstacle.
			var obstacle:Mesh = obstaclesModel.getRandomObstacle().clone() as Mesh;
			// Add it to the model.
			var numObstacles:int = trackModel.numObstacles;
			if ( numObstacles > 0 ) {
				var lastObstacle:Mesh = trackModel.getObstacleAt( numObstacles - 1 );
				obstacle.z = lastObstacle.z + lastObstacle.bounds.max.z + Constants.OBSTACLE_GAP;
			} else {
				obstacle.z = Constants.TRACK_LENGTH;
			}
			trackModel.addZ = obstacle.z;
			trackModel.addObstacle( obstacle );
			// Add to view.
			var event:AddObjectToSceneRequest = new AddObjectToSceneRequest( AddObjectToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED, obstacle );
			eventDispatcher.dispatchEvent( event );
			
			// Add floor after obstacle.
			var floorPos:Number = obstacle.z + obstacle.bounds.max.z;
			trace("floorPos: " + floorPos);
			trace("limit: " + (obstacle.z + obstacle.bounds.max.z + Constants.OBSTACLE_GAP));
			while ( floorPos <= obstacle.z + obstacle.bounds.max.z + Constants.OBSTACLE_GAP ) {
				var floor:Mesh = floorsModel.getFloor( "floor" ).clone() as Mesh;
				floor.z = floorPos + Constants.BLOCK_SIZE * .5;
				trackModel.addObstacle( floor );
				trace("    floor: " + floor);
				var event:AddObjectToSceneRequest = new AddObjectToSceneRequest( AddObjectToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED, floor );
				eventDispatcher.dispatchEvent( event );
				floorPos += Constants.BLOCK_SIZE;
				trace("    " + floorPos);
			}
		}
	}
}
