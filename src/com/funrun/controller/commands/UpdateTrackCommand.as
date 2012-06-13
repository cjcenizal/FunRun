package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddObstaclesRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.ObstacleData;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateTrackCommand extends Command {
		
		// Arguments.
		[Inject]
		public var speed:Number;
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var addObstacleRequests:AddObstaclesRequest;
		
		override public function execute():void {
			if ( Math.abs( speed ) > 0 ) {
				// Move obstacles.
				trackModel.move( speed );
				
				if ( trackModel.numObstacles > 0 ) {
					// Remove obstacles from end of track.
					var obstacle:ObstacleData = trackModel.getObstacleAt( 0 );
					while ( obstacle.z < TrackConstants.REMOVE_SEGMENT_DEPTH ) {
						removeObjectFromSceneRequest.dispatch( obstacle.mesh );
						trackModel.removeObstacleAt( 0 );
						obstacle = trackModel.getObstacleAt( 0 );
					}
				}
			}
			addObstacleRequests.dispatch();
		}
	}
}
