package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddObstaclesRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.payload.UpdateTrackPayload;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.ObstacleData;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateTrackCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var payload:UpdateTrackPayload;
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var addObstacleRequests:AddObstaclesRequest;
		
		override public function execute():void {
			/*
			if ( Math.abs( payload.speed ) > 0 ) {
				if ( trackModel.numObstacles > 0 ) {
					for ( var i:int = 0; i < tracklModel.n
					// Remove obstacles from end of track.
					var obstacle:ObstacleData = trackModel.getObstacleAt( 0 );
					while ( obstacle.z < TrackConstants.REMOVE_SEGMENT_DEPTH ) {
						removeObjectFromSceneRequest.dispatch( obstacle.mesh );
						trackModel.removeObstacleAt( 0 );
						obstacle = trackModel.getObstacleAt( 0 );
					}
				}
			}*/
			// FIX
			for ( var i:int = 0; i < trackModel.numObstacles; i++ ) {
				var obstacle:ObstacleData = trackModel.getObstacleAt( i );
				if ( obstacle.z < payload.positionZ - 5000 || obstacle.z > payload.positionZ + TrackConstants.TRACK_DEPTH ) {
					removeObjectFromSceneRequest.dispatch( obstacle.mesh );
					trackModel.removeObstacleAt( i );
					i--;
				}
			}
			addObstacleRequests.dispatch( payload.positionZ );
		}
	}
}
