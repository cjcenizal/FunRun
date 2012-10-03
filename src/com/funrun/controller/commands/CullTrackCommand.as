package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.model.GameModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.constants.Track;
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
		public var gameModel:GameModel;
		
		// Private vars.
		
		private var _nearSide:Number;
		private var _farSide:Number;
		private var _nearPointSide:Number;
		private var _farPointSide:Number;
		
		override public function execute():void {
			_nearSide = positionZ + Track.CULL_DEPTH_NEAR;
			_farSide = positionZ + Track.CULL_DEPTH_FAR;
			
			// Cull segments.
			for ( var i:int = 0; i < trackModel.numSegments; i++ ) {
				var segment:SegmentVo = trackModel.getSegmentAt( i );
				if ( segment.z < _nearSide
					|| segment.z > _farSide ) {
					
					// Cull points in segment's bounds.
					_nearPointSide = segment.z;
					_farPointSide = _nearPointSide + Segment.DEPTH;
					for ( var j:int = 0; j < pointsModel.numPoints; j++ ) {
						var point:PointVo = pointsModel.getPointAt( j );
						if ( point.meshZ > _nearPointSide
							&& point.meshZ < _farPointSide ) {
							removeObjectFromSceneRequest.dispatch( point.mesh );
							pointsModel.removePointAt( j );
							j--;
						}
					}
					
					removeObjectFromSceneRequest.dispatch( ( gameModel.showBounds ) ? segment.boundsMesh : segment.mesh );
					trackModel.removeSegmentAt( i );
					i--;
				}
			}
		}
	}
}
