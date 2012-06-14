package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddObstacleRequest;
	import com.funrun.controller.signals.payload.AddObstaclePayload;
	import com.funrun.model.TrackModel;
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
		public var addObstacleRequest:AddObstacleRequest;
		
		override public function execute():void {
			var index:int;
			
			// Fill up track on the near side.
			while ( trackModel.depthOfFirstObstacle > positionZ + TrackConstants.SEGMENT_ADD_DEPTH_NEAR ) {
				index = Math.floor( trackModel.depthOfFirstObstacle / TrackConstants.SEGMENT_DEPTH ) - 1;
				if ( index < 0 ) {
					break;
				}
				addObstacleRequest.dispatch( new AddObstaclePayload( index ) );
			}
			
			// Fill up track on the far side.
			while ( trackModel.depthOfLastObstacle < positionZ + TrackConstants.SEGMENT_ADD_DEPTH_FAR ) {
				index = Math.floor( trackModel.depthOfLastObstacle / TrackConstants.SEGMENT_DEPTH ) + 1;
				if ( index < 0 ) {
					break;
				}
				addObstacleRequest.dispatch( new AddObstaclePayload( index ) );
			}
		}
	}
}
