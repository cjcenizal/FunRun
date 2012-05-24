package com.funrun.controller.commands {
	
	import com.funrun.controller.events.DisplayDistanceRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.CameraModel;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TrackModel;
	
	import org.robotlegs.mvcs.Command;

	public class ResetGameCommand extends Command {

		[Inject]
		public var trackModel:TrackModel;

		[Inject]
		public var playerModel:PlayerModel;

		[Inject]
		public var cameraModel:CameraModel;

		[Inject]
		public var distanceModel:DistanceModel;
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		override public function execute():void {
			// Reset distance.
			distanceModel.distance = 0;
			eventDispatcher.dispatchEvent( new DisplayDistanceRequest( DisplayDistanceRequest.DISPLAY_DISTANCE_REQUESTED, distanceModel.distance ) );
			// Reset player.
			resetPlayerRequest.dispatch();
			// Reset camera.
			cameraModel.x = 0;
			cameraModel.y = 100;
			cameraModel.update();
			// Reset obstacles.
			while ( trackModel.numObstacles > 0 ) {
				removeObjectFromSceneRequest.dispatch( trackModel.getObstacleAt( 0 ).mesh );
				trackModel.removeObstacleAt( 0 );
			}
		}
	}
}
