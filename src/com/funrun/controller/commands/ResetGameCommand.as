package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.View3DModel;
	
	import org.robotlegs.mvcs.Command;

	public class ResetGameCommand extends Command {

		// Models.
		
		[Inject]
		public var trackModel:TrackModel;

		[Inject]
		public var cameraModel:View3DModel;

		[Inject]
		public var distanceModel:DistanceModel;
		
		// Commands.
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var displayDistanceRequest:DisplayDistanceRequest;
		
		override public function execute():void {
			// Reset distance.
			distanceModel.reset();
			displayDistanceRequest.dispatch( distanceModel.distanceString );
			// Reset player.
			resetPlayerRequest.dispatch();
			// Reset camera.
			cameraModel.cameraX = 0;
			cameraModel.cameraY = 100;
			cameraModel.update();
			// Reset obstacles.
			while ( trackModel.numObstacles > 0 ) {
				removeObjectFromSceneRequest.dispatch( trackModel.getObstacleAt( 0 ).mesh );
				trackModel.removeObstacleAt( 0 );
			}
		}
	}
}
