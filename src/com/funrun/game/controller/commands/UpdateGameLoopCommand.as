package com.funrun.game.controller.commands {
	
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.DisplayDistanceRequest;
	import com.funrun.game.controller.events.KillPlayerRequest;
	import com.funrun.game.controller.events.RemoveObjectFromSceneRequest;
	import com.funrun.game.controller.events.RenderSceneRequest;
	import com.funrun.game.controller.signals.ResetPlayerRequest;
	import com.funrun.game.controller.signals.ToggleCountdownRequest;
	import com.funrun.game.controller.signals.UpdateCountdownRequest;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.CountdownModel;
	import com.funrun.game.model.DistanceModel;
	import com.funrun.game.model.GameModel;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.TimeModel;
	import com.funrun.game.model.TrackModel;
	import com.funrun.game.model.collision.CollisionsCollection;
	import com.funrun.game.model.collision.FaceCollision;
	import com.funrun.game.model.collision.ObstacleData;
	import com.funrun.game.model.constants.CollisionTypes;
	import com.funrun.game.model.constants.FaceTypes;
	import com.funrun.game.model.constants.TrackConstants;
	import com.funrun.game.model.events.TimeEvent;
	import com.funrun.game.model.state.GameState;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateGameLoopCommand extends Command {
		
		[Inject]
		public var timeEvent:TimeEvent;
		
		[Inject]
		public var trackModel:TrackModel;

		[Inject]
		public var playerModel:PlayerModel;

		[Inject]
		public var cameraModel:CameraModel;

		[Inject]
		public var timeModel:TimeModel;

		[Inject]
		public var distanceModel:DistanceModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		[Inject]
		public var updateCountdownRequest:UpdateCountdownRequest;
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		override public function execute():void {
			// Update countdown if necessary.
			if ( gameModel.gameState == GameState.WAITING_FOR_PLAYERS ) {
				if ( countdownModel.getSecondsRemaining( TrackConstants.WAIT_SECONDS ) > 0 ) {
					updateCountdownRequest.dispatch( countdownModel.getSecondsRemaining( TrackConstants.WAIT_SECONDS ).toString() );
				} else {
					updateCountdownRequest.dispatch( "" );
					toggleCountdownRequest.dispatch( false );
					gameModel.gameState = GameState.RUNNING;
				}
			}
			
			// Target 30 frames per second.
			var framesElapsed:int = Math.round( .03 * timeEvent.delta );
			for ( var f:int = 0; f < framesElapsed; f++ ) {
				if ( gameModel.gameState == GameState.RUNNING ) {
					// Update obstacles.
					trackModel.move( -playerModel.speed );
				}
	
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
					eventDispatcher.dispatchEvent( new AddObstacleRequest( AddObstacleRequest.ADD_OBSTACLE_REQUESTED ) );
				}
	
				if ( playerModel.isDead ) {
					// Slow down when you're dead.
					playerModel.lateralVelocity *= .6;
					playerModel.speed *= .7;
				} else {
					if ( gameModel.gameState == GameState.RUNNING ) {
						// Store distance.
						distanceModel.add( playerModel.speed );
						eventDispatcher.dispatchEvent( new DisplayDistanceRequest( DisplayDistanceRequest.DISPLAY_DISTANCE_REQUESTED, distanceModel.distance ) );
						// Update speed when you're alive.
						if ( Math.abs( playerModel.lateralVelocity ) > 0 ) {
							if ( playerModel.speed > TrackConstants.SLOWED_DIAGONAL_SPEED ) {
								playerModel.speed--;
							}
						} else if ( playerModel.speed < TrackConstants.MAX_PLAYER_FORWARD_VELOCITY ) {
							playerModel.speed += TrackConstants.PLAYER_FOWARD_ACCELERATION;
						}
					}
					// Update jumping.
					if ( playerModel.isJumping && !playerModel.isAirborne ) {
						playerModel.jump( TrackConstants.PLAYER_JUMP_SPEED );
						playerModel.isAirborne = true;
					}
					// Update lateral position.
					playerModel.player.x += playerModel.lateralVelocity;
				}
	
				// Update gravity.
				playerModel.jumpVelocity += TrackConstants.PLAYER_GRAVITY;
				playerModel.player.y += playerModel.jumpVelocity;
				
				// Apply ducking state.
				if ( playerModel.isDucking ) {
					if ( playerModel.player.scaleY != .25 ) {
						playerModel.player.scaleY = .25;
						playerModel.player.bounds.min.y *= .25;
						playerModel.player.bounds.max.y *= .25;
					}
				} else {
					if ( playerModel.player.scaleY != 1 ) {
						playerModel.player.scaleY = 1;
						playerModel.player.bounds.min.y /= .25;
						playerModel.player.bounds.max.y /= .25;
					}
				}
				
				// Collect all collisions.
				var collisions:CollisionsCollection = new CollisionsCollection();
				collisions.collectCollisions( trackModel, playerModel.player.x + playerModel.player.bounds.min.x, playerModel.player.y + playerModel.player.bounds.min.y, playerModel.player.z + playerModel.player.bounds.min.z, playerModel.player.x + playerModel.player.bounds.max.x, playerModel.player.y + playerModel.player.bounds.max.y, playerModel.player.z + playerModel.player.bounds.max.z );
	
				// TO-DO: We can optimize our collision detection by only testing against sides
				// that oppose the direction in which we're moving.
				// This will reduce our testing calculations by about 50%.
	
				// Resolve collisions.
				var numCollisions = collisions.numCollisions;
				var face:FaceCollision;
				if ( numCollisions > 0 ) {
					for ( var i:int = 0; i < numCollisions; i++ ) {
						face = collisions.getAt( i );
						// If the player is moving up, hit the bottom sides of things.
						if ( playerModel.jumpVelocity > 0 ) {
							if ( face.type == FaceTypes.BOTTOM ) {
								playerModel.jumpVelocity = TrackConstants.BOUNCE_OFF_BOTTOM_VELOCITY;
								playerModel.player.y = ( playerModel.isDucking ) ? face.minY - TrackConstants.PLAYER_HALF_SIZE * .25 : face.minY - TrackConstants.PLAYER_HALF_SIZE;
							}
							playerModel.isAirborne = true;
						} else {
							// Else hit the top sides of things.
							if ( face.type == FaceTypes.TOP ) {
								if ( face.maxY > TrackConstants.CULL_FLOOR ) {
									playerModel.player.y = ( playerModel.isDucking ) ? face.maxY + TrackConstants.PLAYER_HALF_SIZE * .25 : face.maxY + TrackConstants.PLAYER_HALF_SIZE;
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
							if ( face.type == FaceTypes.RIGHT ) {
	
							}
						} else if ( playerModel.lateralVelocity > 0 ) {
							// Else if we're moving right, hit the left sides of things.
							if ( face.type == FaceTypes.LEFT ) {
	
							}
						}
						// Always hit the front sides of things.
						if ( face.type == FaceTypes.FRONT ) {
							// Resolve this collision by moving the world.
							trackModel.move( face.minZ );
							if ( face.event == CollisionTypes.SMACK ) {
								eventDispatcher.dispatchEvent( new KillPlayerRequest( KillPlayerRequest.KILL_PLAYER_REQUESTED, CollisionTypes.SMACK ) );
							}
						}
					}
				} else {
					// If we're not hitting something, we're airborne.
					playerModel.isAirborne = true;
					if ( playerModel.player.y < TrackConstants.FALL_DEATH_HEIGHT ) {
						if ( gameModel.gameState == GameState.WAITING_FOR_PLAYERS ) {
							resetPlayerRequest.dispatch();
						} else if ( gameModel.gameState == GameState.RUNNING ) {
							eventDispatcher.dispatchEvent( new KillPlayerRequest( KillPlayerRequest.KILL_PLAYER_REQUESTED, CollisionTypes.FALL ) );
						}
					}
				}
	
				// Update camera.
				cameraModel.x = playerModel.player.x;
				var followFactor:Number = ( TrackConstants.CAM_Y + playerModel.player.y < cameraModel.y ) ? .3 : .1;
				// We'll try easing to follow the player instead of being locked.
				cameraModel.y += ( ( TrackConstants.CAM_Y + playerModel.player.y ) - cameraModel.y ) * followFactor;
				cameraModel.z = -1000;
				cameraModel.update();
			}
			// Render.
			eventDispatcher.dispatchEvent( new RenderSceneRequest( RenderSceneRequest.RENDER_SCENE_REQUESTED ) );
		}
	}
}
