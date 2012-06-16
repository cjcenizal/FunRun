package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddObstaclesRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.payload.UpdateTrackPayload;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.SegmentData;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateTrackCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var payload:UpdateTrackPayload;
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var addObstaclesRequest:AddObstaclesRequest;
		
		override public function execute():void {
			for ( var i:int = 0; i < trackModel.numObstacles; i++ ) {
				var obstacle:SegmentData = trackModel.getObstacleAt( i );
				if ( obstacle.z < payload.positionZ - TrackConstants.SEGMENT_CULL_DEPTH_NEAR
					|| obstacle.z > payload.positionZ + TrackConstants.SEGMENT_CULL_DEPTH_FAR ) {
					removeObjectFromSceneRequest.dispatch( obstacle.mesh );
					trackModel.removeObstacleAt( i );
					i--;
				}
			}
			addObstaclesRequest.dispatch( payload.positionZ );
		}
	}
}
