package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddObstacleRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.ObstacleData;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateObstaclesCommand extends Command {
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var addObstacleRequest:AddObstacleRequest;
		
		override public function execute():void {
			// Move obstacles.
			trackModel.move( -playerModel.velocity.z );
			
			// Remove obstacles from end of track.
			if ( trackModel.numObstacles > 0 ) {
				var obstacle:ObstacleData = trackModel.getObstacleAt( 0 );
				while ( obstacle.z < TrackConstants.REMOVE_SEGMENT_DEPTH ) {
					removeObjectFromSceneRequest.dispatch( obstacle.mesh );
					trackModel.removeObstacleAt( 0 );
					obstacle = trackModel.getObstacleAt( 0 );
				}
			}
			
			// Add new obstacles until track is full again.
			while ( trackModel.depthOfLastObstacle < TrackConstants.TRACK_DEPTH + TrackConstants.BLOCK_SIZE ) {
				addObstacleRequest.dispatch();
			}
		}
	}
}
