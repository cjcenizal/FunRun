package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddFloorRequest;
	import com.funrun.controller.signals.AddObstaclesRequest;
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;

	public class ResetGameCommand extends Command {

		// Models.
		
		[Inject]
		public var trackModel:TrackModel;

		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var timeModel:TimeModel;
		
		// Commands.
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		[Inject]
		public var addObstaclesRequest:AddObstaclesRequest;
		
		[Inject]
		public var addFloorRequest:AddFloorRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var displayDistanceRequest:DisplayDistanceRequest;
		
		[Inject]
		public var view3DModel:View3DModel;
		
		override public function execute():void {
			// Reset time.
			timeModel.reset();
			// Remove all existing obstacles.
			while ( trackModel.numObstacles > 0 ) {
				removeObjectFromSceneRequest.dispatch( trackModel.getObstacleAt( 0 ).mesh );
				trackModel.removeObstacleAt( 0 );
			}
			// Reset distance.
			playerModel.positionZ = 0;
			displayDistanceRequest.dispatch( playerModel.distanceString );
			// Reset player.
			resetPlayerRequest.dispatch();
			// Reset floor and obstacles.
			addFloorRequest.dispatch();
			addObstaclesRequest.dispatch( playerModel.positionZ );
			// Reset camera.
			view3DModel.cameraX = 0;
			view3DModel.cameraY = TrackConstants.CAM_Y;
			view3DModel.cameraZ = TrackConstants.CAM_Z;
			view3DModel.cameraRotationX = TrackConstants.CAM_TILT;
			view3DModel.cameraRotationY = 0;
			view3DModel.cameraRotationZ = 0;
			view3DModel.update();
		}
	}
}
