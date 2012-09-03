package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.model.vo.SegmentVo;
	
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
		
		// State.
		
		[Inject]
		public var showBoundsState:ShowBoundsState;
		
		override public function execute():void {
			for ( var i:int = 0; i < trackModel.numObstacles; i++ ) {
				var obstacle:SegmentVo = trackModel.getObstacleAt( i );
				if ( obstacle.z < positionZ + Segment.CULL_DEPTH_NEAR
					|| obstacle.z > positionZ + Segment.CULL_DEPTH_FAR ) {
					removeObjectFromSceneRequest.dispatch( ( showBoundsState.showBounds ) ? obstacle.boundsMesh : obstacle.mesh );
					trackModel.removeObstacleAt( i );
					i--;
				}
			}
		}
	}
}
