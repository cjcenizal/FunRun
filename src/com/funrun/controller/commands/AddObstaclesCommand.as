package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddSegmentRequest;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.constants.Track;
	import com.funrun.model.vo.AddSegmentVo;
	
	import org.robotlegs.mvcs.Command;

	public class AddObstaclesCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var positionZ:Number;
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var addSegmentRequest:AddSegmentRequest;
		
		// Private vars.
		
		private var _nearSide:Number;
		private var _farSide:Number;
		
		override public function execute():void {
			var index:int;
			_nearSide = positionZ + Track.CULL_DEPTH_NEAR;
			_farSide = positionZ + Track.CULL_DEPTH_FAR;
			
			while ( nearSideCanFitMoreSegments() ) {
				index = Math.floor( trackModel.depthOfFirstSegment / Segment.DEPTH ) - 1;
				if ( index < 0 ) {
					break;
				}
				addSegmentRequest.dispatch( new AddSegmentVo( index ) );
			}
			
			while ( farSideCanFitMoreSegments() ) {
				index = Math.floor( trackModel.depthOfLastSegment / Segment.DEPTH ) + 1;
				if ( index < 0 ) {
					break;
				}
				addSegmentRequest.dispatch( new AddSegmentVo( index ) );
			}
		}
		
		private function nearSideCanFitMoreSegments():Boolean {
			// Estimate where a new segment would fall, and see if it falls in bounds.
			return ( trackModel.depthOfFirstSegment - Segment.DEPTH ) > _nearSide;
		}
		
		private function farSideCanFitMoreSegments():Boolean {
			// Estimate where a new segment would fall, and see if it falls in bounds.
			return ( trackModel.depthOfLastSegment + Segment.DEPTH ) < _farSide;
		}
	}
}
