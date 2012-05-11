package com.funrun.game.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.RemoveObjectFromSceneRequest;
	import com.funrun.game.controller.events.RenderSceneRequest;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.TrackModel;
	import com.funrun.game.model.constants.TrackConstants;
	import com.funrun.game.model.data.BoundingBoxData;
	import com.funrun.game.model.data.ObstacleData;
	
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
				var obstacle:ObstacleData = trackModel.getObstacleAt( 0 );
				while ( obstacle.z < TrackConstants.REMOVE_OBSTACLE_DEPTH ) {
					eventDispatcher.dispatchEvent( new RemoveObjectFromSceneRequest( RemoveObjectFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED, obstacle.mesh ) );
					trackModel.removeObstacleAt( 0 );
					obstacle = trackModel.getObstacleAt( 0 );
				}
			}
			
			// Add new obstacles until track is full again.
			while ( trackModel.depthOfLastObstacle < TrackConstants.TRACK_LENGTH + TrackConstants.BLOCK_SIZE ) {
				// Add obstacles to fill up track.
				eventDispatcher.dispatchEvent( new AddObstacleRequest( AddObstacleRequest.ADD_OBSTACLE_REQUESTED ) );
			}
			
			// Collisions.
			var len:int = trackModel.numObstacles;
			var obstacle:ObstacleData;
			var playerX:Number = playerModel.player.x;
			var playerY:Number = playerModel.player.y;
			var playerZ:Number = playerModel.player.z;
			var minX:Number = playerModel.player.bounds.min.x;
			var maxX:Number = playerModel.player.bounds.max.x;
			var minY:Number = playerModel.player.bounds.min.y;
			var maxY:Number = playerModel.player.bounds.max.y;
			var minZ:Number = playerModel.player.bounds.min.z;
			var maxZ:Number = playerModel.player.bounds.max.z;
			trace("=====================================");
			for ( var i:int = 0; i < len; i++ ) {
				//trace(i);
				obstacle = trackModel.getObstacleAt( i );
				obstacle.getCollisions( playerX, playerY, playerZ, minX, maxX, minY, maxY, minZ, maxZ );
			}
			
			// Update player.
			playerModel.jumpVelocity += TrackConstants.PLAYER_JUMP_GRAVITY;
			playerModel.player.y += playerModel.jumpVelocity;
			playerModel.player.x += playerModel.lateralVelocity;
			if ( playerModel.player.y <= 25 ) {
				playerModel.isAirborne = false
			}
			if ( playerModel.player.y < 25 ) { // Temp hack for landing on ground, fix later
				playerModel.player.y = 25; // 25 is half the player FPO object's height
				playerModel.jumpVelocity *= -.4;
			}
			
			// TO-DO: Make ducking cooler.
			if ( playerModel.isDucking ) {
				playerModel.player.scaleY = .5;
			} else {
				playerModel.player.scaleY = 1;
			}
			
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