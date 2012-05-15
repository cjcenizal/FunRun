package com.funrun.game.controller.commands
{
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.RemoveObjectFromSceneRequest;
	import com.funrun.game.controller.events.RenderSceneRequest;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.TrackModel;
	import com.funrun.game.model.constants.FaceTypes;
	import com.funrun.game.model.constants.TrackConstants;
	import com.funrun.game.model.data.CollisionData;
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
			
			// Update player.
			if ( playerModel.isJumping && !playerModel.isAirborne ) {
				playerModel.jump( TrackConstants.PLAYER_JUMP_SPEED );
			}
			
			playerModel.jumpVelocity += TrackConstants.PLAYER_GRAVITY;
			playerModel.player.x += playerModel.lateralVelocity;
			playerModel.player.y += playerModel.jumpVelocity;
			
			// TO-DO: Make ducking cooler.
			if ( playerModel.isDucking ) {
				playerModel.player.scaleY = .5;
			} else {
				playerModel.player.scaleY = 1;
			}
			
			// Collisions.
			
			// TO-DO: Do interpolation here.
			
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
			
			// Collect all collisions.
			var collisions:Array = [];
			for ( var i:int = 0; i < len; i++ ) {
				obstacle = trackModel.getObstacleAt( i );
				var collisionData:CollisionData = CollisionData.make( obstacle, playerX + minX, playerX + maxX, playerY + minY, playerY + maxY, playerZ + minZ, playerZ + maxZ );
				if ( collisionData ) {
					collisions.push( collisionData );
				}
			}
			
			// Figure out at which height to resolve collisions.
			var walkHeight:int = TrackConstants.CULL_FLOOR;
			for ( var i:int = 0; i < collisions.length; i++ ) {
				var collisionData:CollisionData = collisions[ i ];
				for ( var j:int = 0; j < collisionData.numCollisions; j++ ) {
					// Resolve collisions by placing player on top of any boxes we collide with.
					if ( collisionData.getFaceAt( j ) == FaceTypes.TOP
						&& ( collisionData.getBoxAt( j ) ).block.doesFaceCollide( FaceTypes.TOP ) ) {
					//	&& ( collisionData.getBoxAt( j ) ).block.getEventAtFace( FaceTypes.TOP ) == "walk" ) {
						// Of all the faces we've collided with, find the highest one.
						walkHeight = Math.max( walkHeight, collisionData.getBoxAt( j ).maxY );
					}
				}
			}
			
			// Reposition the player if we need to resolve a collision.
			if ( walkHeight > TrackConstants.CULL_FLOOR ) {
				playerModel.player.y = walkHeight + 25;
				playerModel.jumpVelocity = 0;
				playerModel.isAirborne = false;
				
				// TO-DO: Remove invalidated collisions.
				//collisions.resolveWithNewPosition( playerModel.player.x
			} else {
				// The player is airborne if he's not colliding with a floor.
				playerModel.isAirborne = true;
			}
			
			// TO-DO: Resolve additional collisions (hitting sides and front).
			
			// TO-DO: Apply additional events based on collisions.
			// Apply logic for removing redundant events.
			
			
			
			
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