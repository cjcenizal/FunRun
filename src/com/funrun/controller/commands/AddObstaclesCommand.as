package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddSegmentRequest;
	import com.funrun.controller.signals.payload.AddSegmentPayload;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.SegmentTypes;
	import com.funrun.model.constants.TrackConstants;
	
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
		public var addObstacleRequest:AddSegmentRequest;
		
		override public function execute():void {
			var index:int;
			
			// Fill up track on the near side.
			while ( trackModel.depthOfFirstObstacle > positionZ + TrackConstants.SEGMENT_ADD_DEPTH_NEAR ) {
				index = Math.floor( trackModel.depthOfFirstObstacle / TrackConstants.SEGMENT_DEPTH ) - 1;
				if ( index < 0 ) {
					break;
				}
				addObstacleRequest.dispatch( new AddSegmentPayload( SegmentTypes.OBSTACLE, index ) );
			}
			
			// Fill up track on the far side.
			while ( trackModel.depthOfLastObstacle < positionZ + TrackConstants.SEGMENT_ADD_DEPTH_FAR ) {
				index = Math.floor( trackModel.depthOfLastObstacle / TrackConstants.SEGMENT_DEPTH ) + 1;
				if ( index < 0 ) {
					break;
				}
				addObstacleRequest.dispatch( new AddSegmentPayload( SegmentTypes.OBSTACLE, index ) );
			}
		}
	}
}
