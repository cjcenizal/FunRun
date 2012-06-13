package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddObstacleRequest;
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
			
			// Fill up track from the front to the back.
			while ( trackModel.depthOfLastObstacle < TrackConstants.TRACK_DEPTH + TrackConstants.BLOCK_SIZE ) {
				index = Math.floor( ( positionZ + trackModel.depthOfLastObstacle ) / TrackConstants.SEGMENT_DEPTH ) + 1;
				//trace("add forward " + index);
				addObstacleRequest.dispatch( index );
			}
			
			//index = Math.floor( positionZ + trackModel.depthOfFirstObstacle ) / TrackConstants.SEGMENT_DEPTH;
			//trace("add backward " + index);
			// Fill up track from the back to the front.
			/*while ( trackModel.depthOfFirstObstacle > TrackConstants.REMOVE_SEGMENT_DEPTH + TrackConstants.SEGMENT_DEPTH ) {
				var index:int = Math.floor( positionZ + trackModel.depthOfFirstObstacle ) / TrackConstants.SEGMENT_DEPTH;
				trace("add backward " + index);
				addObstacleRequest.dispatch( index );
			}*/
		}
	}
}
