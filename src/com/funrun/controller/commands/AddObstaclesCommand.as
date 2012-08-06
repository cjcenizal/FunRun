package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddSegmentRequest;
	import com.funrun.controller.signals.payload.AddSegmentPayload;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.constants.Track;
	
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
		
		override public function execute():void {
			var index:int;
			
			// Fill up track on the near side.
			while ( trackModel.depthOfFirstObstacle > positionZ + Track.SEGMENT_ADD_DEPTH_NEAR ) {
				index = Math.floor( trackModel.depthOfFirstObstacle / Segment.SEGMENT_DEPTH ) - 1;
				if ( index < 0 ) {
					break;
				}
				addSegmentRequest.dispatch( new AddSegmentPayload( index ) );
			}
			
			// Fill up track on the far side.
			while ( trackModel.depthOfLastObstacle < positionZ + Track.SEGMENT_ADD_DEPTH_FAR ) {
				index = Math.floor( trackModel.depthOfLastObstacle / Segment.SEGMENT_DEPTH ) + 1;
				if ( index < 0 ) {
					break;
				}
				addSegmentRequest.dispatch( new AddSegmentPayload( index ) );
			}
		}
	}
}
