package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.payload.AddFloorPayload;
	import com.funrun.model.FloorsModel;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.ObstacleData;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddObstacleCommand extends Command {
		
		[Inject]
		public var obstaclesModel:ObstaclesModel;
		
		[Inject]
		public var floorsModel:FloorsModel;
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void {
			// Get an obstacle.
			var obstacle:ObstacleData = obstaclesModel.getNext();
			// Add it to the model.
			var numObstacles:int = trackModel.numObstacles;
			if ( numObstacles > 0 ) {
				obstacle.z = trackModel.depthOfLastObstacle + TrackConstants.SEGMENT_DEPTH;
			} else {
				obstacle.z = 0;
			}
			trackModel.addObstacle( obstacle );
			// Add to view.
			addObjectToSceneRequest.dispatch( obstacle.mesh );
		}
	}
}
