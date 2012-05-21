package com.funrun.game.controller.commands {
	
	import com.funrun.game.controller.events.RemoveObjectFromSceneRequest;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.TrackModel;
	import com.funrun.game.model.constants.TrackConstants;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;

	public class ResetPlayerCommand extends Command {

		[Inject]
		public var trackModel:TrackModel;

		[Inject]
		public var playerModel:PlayerModel;

		[Inject]
		public var cameraModel:CameraModel;

		override public function execute():void {
			// Resurrect plater.
			playerModel.isDead = false;
			// Reset player and camera position.
			playerModel.speed = playerModel.jumpVelocity = playerModel.lateralVelocity = 0;
			playerModel.player.position = new Vector3D( 0, TrackConstants.PLAYER_HALF_SIZE, 0 );
			cameraModel.x = 0;
			cameraModel.y = 100;
			cameraModel.update();
			// Remove any old obstacles.
			while ( trackModel.numObstacles > 0 ) {
				var removeEvent:RemoveObjectFromSceneRequest = new RemoveObjectFromSceneRequest( RemoveObjectFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED, trackModel.getObstacleAt( 0 ).mesh );
				eventDispatcher.dispatchEvent( removeEvent );
				trackModel.removeObstacleAt( 0 );
			}
		}
	}
}
