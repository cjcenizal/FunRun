package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.model.TrackModel;
	import com.funrun.model.vo.SegmentVO;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;

	public class CullSegmentsCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var positionZ:Number;
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		override public function execute():void {
			for ( var i:int = 0; i < trackModel.numObstacles; i++ ) {
				var obstacle:SegmentVO = trackModel.getObstacleAt( i );
				if ( obstacle.z < positionZ + TrackConstants.SEGMENT_CULL_DEPTH_NEAR
					|| obstacle.z > positionZ + TrackConstants.SEGMENT_CULL_DEPTH_FAR ) {
					removeObjectFromSceneRequest.dispatch( obstacle.mesh );
					trackModel.removeObstacleAt( i );
					i--;
				}
			}
		}
	}
}
