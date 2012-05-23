package com.funrun.game.controller.commands {
	
	import com.funrun.game.controller.events.DisplayDistanceRequest;
	import com.funrun.game.controller.events.RemoveObjectFromSceneRequest;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.DistanceModel;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.TrackModel;
	import com.funrun.game.model.constants.TrackConstants;
	
	import flash.geom.Vector3D;
	
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
		
		override public function execute():void {
			// Reset distance.
			distanceModel.distance = 0;
			eventDispatcher.dispatchEvent( new DisplayDistanceRequest( DisplayDistanceRequest.DISPLAY_DISTANCE_REQUESTED, distanceModel.distance ) );
			// Reset player.
			playerModel.isDead = false;
			playerModel.isAirborne = false;
			playerModel.isDucking = false;
			playerModel.isJumping = false;
			playerModel.speed = playerModel.jumpVelocity = playerModel.lateralVelocity = 0;
			playerModel.player.position = new Vector3D( 0, TrackConstants.PLAYER_HALF_SIZE, 0 );
			// Reset camera.
			cameraModel.x = 0;
			cameraModel.y = 100;
			cameraModel.update();
			// Reset obstacles.
			while ( trackModel.numObstacles > 0 ) {
				eventDispatcher.dispatchEvent( new RemoveObjectFromSceneRequest( RemoveObjectFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED, trackModel.getObstacleAt( 0 ).mesh ) );
				trackModel.removeObstacleAt( 0 );
			}
		}
	}
}
