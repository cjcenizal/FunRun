package com.funrun.game.controller.commands {
	
	import away3d.entities.Mesh;
	
	import com.funrun.game.controller.events.AddObjectToSceneRequest;
	import com.funrun.game.model.constants.TrackConstants;
	import com.funrun.game.model.constants.FloorTypes;
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
			trace("ok");
			// Get an obstacle.
			var obstacle:Mesh = obstaclesModel.getRandomObstacle().mesh;
			// Add it to the model.
			var numObstacles:int = trackModel.numObstacles;
			if ( numObstacles > 0 ) {
				obstacle.z = trackModel.depthOfLastObstacle;
			} else {
				obstacle.z = TrackConstants.TRACK_LENGTH;
			}
			trackModel.addObstacle( obstacle );
			// Add to view.
			var event:AddObjectToSceneRequest = new AddObjectToSceneRequest( AddObjectToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED, obstacle );
			eventDispatcher.dispatchEvent( event );
			
			// Add floor after obstacle.
			var floorPos:Number = obstacle.z + obstacle.bounds.max.z;
			while ( floorPos < obstacle.z + obstacle.bounds.max.z + TrackConstants.OBSTACLE_GAP ) {
				var floor:Mesh = floorsModel.getFloorClone( FloorTypes.FLOOR );
				floor.z = floorPos + TrackConstants.BLOCK_SIZE * .5;
				trackModel.addObstacle( floor );
				var event:AddObjectToSceneRequest = new AddObjectToSceneRequest( AddObjectToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED, floor );
				eventDispatcher.dispatchEvent( event );
				floorPos += TrackConstants.BLOCK_SIZE;
			}
		}
	}
}
