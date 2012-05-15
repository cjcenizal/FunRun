package com.funrun.game.controller.commands
{
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.RemoveObjectFromSceneRequest;
	import com.funrun.game.controller.events.RenderSceneRequest;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.TrackModel;
	import com.funrun.game.model.constants.FaceTypes;
	import com.funrun.game.model.constants.CollisionTypes;
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
			trackModel.move( -playerModel.speed );
			
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
			
			// Update forward speed.
			if ( playerModel.isDead ) {
				playerModel.lateralVelocity = 0;
				playerModel.speed *= .7;
			} else {
				if ( Math.abs( playerModel.lateralVelocity ) > 0 ) {
					if ( playerModel.speed > TrackConstants.SLOWED_DIAGONAL_SPEED ) {
						playerModel.speed--;
					}
				} else if ( playerModel.speed < TrackConstants.MAX_PLAYER_FORWARD_VELOCITY ) {
					playerModel.speed += TrackConstants.PLAYER_FOWARD_ACCELERATION;
				}
				// Update jumping.
				if ( playerModel.isJumping && !playerModel.isAirborne ) {
					playerModel.jump( TrackConstants.PLAYER_JUMP_SPEED );
					playerModel.isAirborne = true;
				}
				playerModel.player.x += playerModel.lateralVelocity;
			}
			// Update gravity.
			playerModel.jumpVelocity += TrackConstants.PLAYER_GRAVITY;
			playerModel.player.y += playerModel.jumpVelocity;
			
			
			
			
			// TO-DO: Make ducking cooler.
			if ( playerModel.isDucking ) {
				// TO-DO: Reduce collision bounds here.
				playerModel.player.scaleY = .25;
			} else {
				playerModel.player.scaleY = 1;
			}
			
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
			
			// TO-DO: This is an erroneous length when we're falling off the track.
			// TO-DO: We can optimize this by only storing collisions where doesFaceCollide evaluates to true
			// inside of CollisionData.
			trace(collisions.length);
			// Resolve collisions.
			if ( collisions.length > 0 ) {
				for ( var i:int = 0; i < collisions.length; i++ ) {
					var collisionData:CollisionData = collisions[ i ];
					for ( var j:int = 0; j < collisionData.numCollisions; j++ ) {
						// If the player is moving up, hit the bottom sides of things.
						if ( playerModel.jumpVelocity > 0 ) {
							if ( collisionData.getFaceAt( j ) == FaceTypes.BOTTOM
								&& ( collisionData.getBoxAt( j ).block.doesFaceCollide( FaceTypes.BOTTOM ) ) ) {
								playerModel.jumpVelocity = TrackConstants.BOUNCE_OFF_BOTTOM_VELOCITY;
								playerModel.player.y = collisionData.getBoxAt( j ).minY - TrackConstants.PLAYER_HALF_SIZE;
							}
							playerModel.isAirborne = true;
						} else {
							// Else hit the top sides of things.
							if ( collisionData.getFaceAt( j ) == FaceTypes.TOP
								&& ( collisionData.getBoxAt( j ).block.doesFaceCollide( FaceTypes.TOP ) ) ) {
								if ( collisionData.getBoxAt( j ).maxY > TrackConstants.CULL_FLOOR ) {
									playerModel.player.y = collisionData.getBoxAt( j ).maxY + TrackConstants.PLAYER_HALF_SIZE;
									playerModel.jumpVelocity = 0;
									playerModel.isAirborne = false;
								} else {
									// The player is airborne if he's not colliding with a floor.
									playerModel.isAirborne = true;
								}
							}
						}
						// If we're moving left, hit the right sides of things.
						if ( playerModel.lateralVelocity < 0 ) {
							if ( collisionData.getFaceAt( j ) == FaceTypes.RIGHT
								&& ( collisionData.getBoxAt( j ).block.doesFaceCollide( FaceTypes.RIGHT ) ) ) {
								
							}
						} else if ( playerModel.lateralVelocity > 0 ) {
							// Else if we're moving right, hit the left sides of things.
							if ( collisionData.getFaceAt( j ) == FaceTypes.LEFT
								&& ( collisionData.getBoxAt( j ).block.doesFaceCollide( FaceTypes.LEFT ) ) ) {
								
							}
						}
						// Always hit the front sides of things.
						if ( collisionData.getFaceAt( j ) == FaceTypes.FRONT
							&& ( collisionData.getBoxAt( j ).block.doesFaceCollide( FaceTypes.FRONT ) ) ) {
							//playerModel.player.z = collisionData.getBoxAt( j ).minZ - TrackConstants.PLAYER_HALF_SIZE;
							if ( collisionData.getBoxAt( j ).block.getEventAtFace( FaceTypes.FRONT ) == CollisionTypes.SMACK ) {
								playerModel.isDead = true;
								playerModel.speed = TrackConstants.HEAD_ON_SMACK_SPEED;
							}
						}
					}
				}
				var t:Boolean;
			} else {
				trace("airborne");
				playerModel.isAirborne = true;
			}
			
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