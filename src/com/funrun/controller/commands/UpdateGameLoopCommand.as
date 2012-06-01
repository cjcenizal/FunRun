package com.funrun.controller.commands {
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.AddObstacleRequest;
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.controller.signals.SendMultiplayerUpdateRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.controller.signals.UpdateCountdownRequest;
	import com.funrun.controller.signals.UpdatePlacesRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.collision.CollisionsCollection;
	import com.funrun.model.collision.FaceCollision;
	import com.funrun.model.collision.ObstacleData;
	import com.funrun.model.constants.CollisionTypes;
	import com.funrun.model.constants.FaceTypes;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.GameState;
	import com.funrun.model.vo.CompetitorVO;
	
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateGameLoopCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var timeEvent:TimeEvent;
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;

		[Inject]
		public var playerModel:PlayerModel;

		[Inject]
		public var view3DModel:View3DModel;

		[Inject]
		public var timeModel:TimeModel;

		[Inject]
		public var distanceModel:DistanceModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var interpolationModel:InterpolationModel;
		
		[Inject]
		public var nametagsModel:NametagsModel;
		
		// Commands.
		
		[Inject]
		public var startRunningRequest:StartRunningRequest;
		
		[Inject]
		public var updateCountdownRequest:UpdateCountdownRequest;
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		[Inject]
		public var addObstacleRequest:AddObstacleRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var killPlayerRequest:KillPlayerRequest;
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var displayDistanceRequest:DisplayDistanceRequest;
		
		[Inject]
		public var sendMultiplayerUpdateRequest:SendMultiplayerUpdateRequest;
		
		[Inject]
		public var updatePlacesRequest:UpdatePlacesRequest;
		
		override public function execute():void {
			// Update countdown if necessary.
			if ( gameModel.gameState == GameState.WAITING_FOR_PLAYERS ) {
				if ( countdownModel.isRunning ) {
					if ( countdownModel.secondsRemaining > 0 ) {
						updateCountdownRequest.dispatch( countdownModel.secondsRemaining.toString() );
					} else {
						// Start running.
						startRunningRequest.dispatch();
					}
				}
			}
			
			// Target 30 frames per second.
			var framesElapsed:int = Math.round( .03 * timeEvent.delta );
			for ( var f:int = 0; f < framesElapsed; f++ ) {
				if ( gameModel.gameState == GameState.RUNNING ) {
					// Update obstacles.
					trackModel.move( -playerModel.velocity.z );
		
					// Remove obstacles from end of track.
					if ( trackModel.numObstacles > 0 ) {
						var obstacle:ObstacleData = trackModel.getObstacleAt( 0 );
						while ( obstacle.z < TrackConstants.REMOVE_OBSTACLE_DEPTH ) {
							removeObjectFromSceneRequest.dispatch( obstacle.mesh );
							trackModel.removeObstacleAt( 0 );
							obstacle = trackModel.getObstacleAt( 0 );
						}
					}
		
					// Add new obstacles until track is full again.
					while ( trackModel.depthOfLastObstacle < TrackConstants.TRACK_LENGTH + TrackConstants.BLOCK_SIZE ) {
						addObstacleRequest.dispatch();
					}
				}
	
				if ( playerModel.isDead ) {
					// Slow down when you're dead.
					playerModel.velocity.x *= .6;
					playerModel.velocity.z *= .7;
				} else {
					if ( gameModel.gameState == GameState.RUNNING ) {
						// Store distance.
						distanceModel.add( playerModel.velocity.z );
						// Update speed when you're alive.
						if ( Math.abs( playerModel.velocity.x ) > 0 ) {
							if ( playerModel.velocity.z > TrackConstants.SLOWED_DIAGONAL_SPEED ) {
								playerModel.velocity.z--;
							}
						} else if ( playerModel.velocity.z < TrackConstants.MAX_PLAYER_FORWARD_VELOCITY ) {
							playerModel.velocity.z += TrackConstants.PLAYER_FOWARD_ACCELERATION;
						}
					}
					// Update jumping.
					if ( playerModel.isJumping && !playerModel.isAirborne ) {
						playerModel.jump( TrackConstants.PLAYER_JUMP_SPEED );
						playerModel.isAirborne = true;
					}
					// Update lateral position.
					playerModel.player.x += playerModel.velocity.x;
				}
	
				// Update gravity.
				playerModel.velocity.y += TrackConstants.PLAYER_GRAVITY;
				playerModel.player.y += playerModel.velocity.y;
				
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
						if ( playerModel.velocity.y > 0 ) {
							if ( face.type == FaceTypes.BOTTOM ) {
								playerModel.velocity.y = TrackConstants.BOUNCE_OFF_BOTTOM_VELOCITY;
								playerModel.player.y = ( playerModel.isDucking ) ? face.minY - TrackConstants.PLAYER_HALF_SIZE * .25 : face.minY - TrackConstants.PLAYER_HALF_SIZE;
							}
							playerModel.isAirborne = true;
						} else {
							// Else hit the top sides of things.
							if ( face.type == FaceTypes.TOP ) {
								if ( face.maxY > TrackConstants.CULL_FLOOR ) {
									playerModel.player.y = ( playerModel.isDucking ) ? face.maxY + TrackConstants.PLAYER_HALF_SIZE * .25 : face.maxY + TrackConstants.PLAYER_HALF_SIZE;
									playerModel.velocity.y = 0;
									playerModel.isAirborne = false;
								} else {
									// The player is airborne if he's not colliding with a floor.
									playerModel.isAirborne = true;
								}
							}
						}
						// If we're moving left, hit the right sides of things.
						if ( playerModel.velocity.x < 0 ) {
							if ( face.type == FaceTypes.RIGHT ) {
	
							}
						} else if ( playerModel.velocity.x > 0 ) {
							// Else if we're moving right, hit the left sides of things.
							if ( face.type == FaceTypes.LEFT ) {
	
							}
						}
						// Always hit the front sides of things.
						if ( face.type == FaceTypes.FRONT ) {
							// Resolve this collision by moving the world.
							trackModel.move( face.minZ );
							distanceModel.add( -face.minZ );
							if ( face.event == CollisionTypes.SMACK ) {
								killPlayerRequest.dispatch( CollisionTypes.SMACK );
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
							killPlayerRequest.dispatch( CollisionTypes.FALL );
						}
					}
				}
	
				// Update camera.
				view3DModel.cameraX = playerModel.player.x;
				var followFactor:Number = ( TrackConstants.CAM_Y + playerModel.player.y < view3DModel.cameraY ) ? .3 : .1;
				// We'll try easing to follow the player instead of being locked.
				view3DModel.cameraY += ( ( TrackConstants.CAM_Y + playerModel.player.y ) - view3DModel.cameraY ) * followFactor;
				view3DModel.cameraZ = -1000;
				view3DModel.update();
				
				// Update competitors' physics.
				var len:int = competitorsModel.numCompetitors;
				var competitor:CompetitorVO;
				var nametag:AbstractLabel;
				for ( var i:int = 0; i < len; i++ ) {
					competitor = competitorsModel.getAt( i );
					competitor.interpolate( interpolationModel.percent );
					nametag = nametagsModel.getWithId( competitor.id.toString() );
					if ( nametag ) {
						var pos:Point = view3DModel.get2DFrom3D( competitor.mesh.position );
						nametag.x = pos.x;
						nametag.y = pos.y;
					}
				}
				interpolationModel.increment();
			}
			
			// Update distance counter.
			if ( gameModel.gameState == GameState.RUNNING ) {
				displayDistanceRequest.dispatch( distanceModel.distanceString + " feet" );
			}
			
			// Update other players with our position.
			sendMultiplayerUpdateRequest.dispatch();
			
			// Update places.
			updatePlacesRequest.dispatch();
			
			// Render.
			renderSceneRequest.dispatch();
		}
	}
}
