package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddObstacleRequest;
	import com.funrun.model.ObservationModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;

	public class AddObstaclesCommand extends Command {
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		[Inject]
		public var obs:ObservationModel;
		
		// Commands.
		
		[Inject]
		public var addObstacleRequest:AddObstacleRequest;
		
		override public function execute():void {
			// Fill up track from the front to the back.
			while ( trackModel.depthOfLastObstacle < TrackConstants.TRACK_DEPTH + TrackConstants.BLOCK_SIZE ) {
				var index:int = Math.floor( ( obs.position + trackModel.depthOfLastObstacle + TrackConstants.SEGMENT_DEPTH ) / TrackConstants.SEGMENT_DEPTH );
				addObstacleRequest.dispatch( index );
			}
			
			// Fill up track from the back to the front.
		}
	}
}
