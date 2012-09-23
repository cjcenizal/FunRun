package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.model.PointsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Track;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.model.vo.PointVo;
	import com.funrun.model.vo.SegmentVo;
	
	import org.robotlegs.mvcs.Command;

	public class CullTrackCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var positionZ:Number;
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var pointsModel:PointsModel;
		
		// Commands.
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		// State.
		
		[Inject]
		public var showBoundsState:ShowBoundsState;
		
		override public function execute():void {
			
			// Cull segments.
			for ( var i:int = 0; i < trackModel.numSegments; i++ ) {
				var obstacle:SegmentVo = trackModel.getSegmentAt( i );
				if ( obstacle.z < positionZ + Track.CULL_DEPTH_NEAR
					|| obstacle.z > positionZ + Track.CULL_DEPTH_FAR ) {
					removeObjectFromSceneRequest.dispatch( ( showBoundsState.showBounds ) ? obstacle.boundsMesh : obstacle.mesh );
					trackModel.removeSegmentAt( i );
					i--;
				}
			}
			
			// Cull points.
			for ( var i:int = 0; i < pointsModel.numPoints; i++ ) {
				var point:PointVo = pointsModel.getPointAt( i );
				if ( point.meshZ < positionZ + Track.CULL_DEPTH_NEAR
					|| point.meshZ > positionZ + Track.CULL_DEPTH_FAR ) {
					removeObjectFromSceneRequest.dispatch( point.mesh );
					pointsModel.removePointAt( i );
					i--;
				}
			}
		}
	}
}
