package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.payload.AddObstaclePayload;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.ObstacleData;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddObstacleCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var payload:AddObstaclePayload;
		
		// Models.
		
		[Inject]
		public var obstaclesModel:ObstaclesModel;
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void {
			// Get an obstacle, set its position, add it to the model and view.
			var obstacle:ObstacleData = obstaclesModel.getAt( payload.index );
			obstacle.z = payload.index * TrackConstants.SEGMENT_DEPTH - payload.relativePositionZ;
			trackModel.addObstacle( obstacle );
			addObjectToSceneRequest.dispatch( obstacle.mesh );
		}
	}
}
