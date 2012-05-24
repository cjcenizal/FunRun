package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	
	import com.funrun.controller.events.AddFloorsRequest;
	import com.funrun.controller.events.AddObjectToSceneRequest;
	import com.funrun.model.FloorsModel;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.FloorTypes;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.collision.ObstacleData;
	
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
			var obstacle:ObstacleData = obstaclesModel.getRandomObstacle();
			// Add it to the model.
			var numObstacles:int = trackModel.numObstacles;
			if ( numObstacles > 0 ) {
				obstacle.z = trackModel.depthOfLastObstacle;
			} else {
				obstacle.z = TrackConstants.TRACK_LENGTH;
			}
			trackModel.addObstacle( obstacle );
			// Add to view.
			var event:AddObjectToSceneRequest = new AddObjectToSceneRequest( AddObjectToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED, obstacle.mesh );
			eventDispatcher.dispatchEvent( event );
			
			// Add floors.
			var startPos:Number = obstacle.z + obstacle.bounds.max.z;
			var endPos:Number = obstacle.z + obstacle.bounds.max.z + TrackConstants.OBSTACLE_GAP;
			eventDispatcher.dispatchEvent( new AddFloorsRequest( AddFloorsRequest.ADD_FLOORS_REQUESTED, startPos, endPos, TrackConstants.BLOCK_SIZE ) );
		}
	}
}
