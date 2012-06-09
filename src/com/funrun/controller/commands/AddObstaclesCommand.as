package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddObstacleRequest;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;

	public class AddObstaclesCommand extends Command {
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var addObstacleRequest:AddObstacleRequest;
		
		override public function execute():void {
			// Add new obstacles until track is full again.
			while ( trackModel.depthOfLastObstacle < TrackConstants.TRACK_DEPTH + TrackConstants.BLOCK_SIZE ) {
				addObstacleRequest.dispatch();
			}
		}
	}
}
