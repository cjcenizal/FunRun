package com.funrun.game.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.RemoveObjectFromSceneRequest;
	import com.funrun.game.controller.events.RenderSceneRequest;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.constants.TrackConstants;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.TrackModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateGameLoopCommand extends Command
	{
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var cameraModel:CameraModel;
		
		override public function execute():void {
			// Update obstacles.
			trackModel.move( -TrackConstants.MAX_PLAYER_FORWARD_VELOCITY );
			
			// Remove obstacles from end of track.
			if ( trackModel.numObstacles > 0 ) {
				var mesh:Mesh = trackModel.getObstacleAt( 0 );
				while ( mesh.z < TrackConstants.REMOVE_OBSTACLE_DEPTH ) {
					eventDispatcher.dispatchEvent( new RemoveObjectFromSceneRequest( RemoveObjectFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED, mesh ) );
					trackModel.removeObstacleAt( 0 );
					mesh = trackModel.getObstacleAt( 0 );
				}
			}
			
			// Add new obstacles.
			while ( trackModel.depthOfLastObstacle < TrackConstants.TRACK_LENGTH + TrackConstants.BLOCK_SIZE ) {
				// Add obstacles to fill up track.
				eventDispatcher.dispatchEvent( new AddObstacleRequest( AddObstacleRequest.ADD_OBSTACLE_REQUESTED ) );
			}
			
			// Update player.
			playerModel.jumpVelocity += TrackConstants.PLAYER_JUMP_GRAVITY;
			playerModel.player.y += playerModel.jumpVelocity;
			playerModel.player.x += playerModel.lateralVelocity;
			if ( playerModel.player.y <= 25 ) { // Temp hack for landing on ground, fix later
				playerModel.player.y = 25; // 25 is half the player FPO object's height
				playerModel.jumpVelocity = 0;
			}
			playerModel.isAirborne = ( Math.abs( playerModel.player.y - 25 ) > 1 );
			
			// Update camera.
			cameraModel.camera.x = playerModel.player.x;
			var followFactor:Number = ( TrackConstants.CAM_Y + playerModel.player.y < cameraModel.camera.y ) ? .6 : .2;
			// We'll try easing to follow the player instead of being locked.
			cameraModel.camera.y += ( ( TrackConstants.CAM_Y + playerModel.player.y ) - cameraModel.camera.y ) * followFactor; 
			
			// Render.
			eventDispatcher.dispatchEvent( new RenderSceneRequest( RenderSceneRequest.RENDER_SCENE_REQUESTED ) );
		}
	}
}