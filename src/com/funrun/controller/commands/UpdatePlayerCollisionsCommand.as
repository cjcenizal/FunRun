package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.GameModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.CollisionsCollection;
	import com.funrun.model.collision.FaceCollision;
	import com.funrun.model.constants.CollisionTypes;
	import com.funrun.model.constants.FaceTypes;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.state.GameState;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdatePlayerCollisionsCommand extends Command {
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		// Commands.
		
		[Inject]
		public var killPlayerRequest:KillPlayerRequest;
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		override public function execute():void {
			var interpolationDist:Number = TrackConstants.BLOCK_SIZE;
			// TO-DO:
			// Interpolate a fixed distance from previous position
			// to current position, performing collision detection
			// along the way. Exit loop as soon as a collision
			// is detected.
			
			// Collect all collisions.
			var collisions:CollisionsCollection = new CollisionsCollection();
			collisions.collectCollisions(
				trackModel,
				playerModel.positionX + playerModel.bounds.min.x,
				playerModel.positionY + playerModel.bounds.min.y,
				playerModel.bounds.min.z,
				playerModel.positionX + playerModel.bounds.max.x,
				playerModel.positionY + playerModel.bounds.max.y,
				playerModel.bounds.max.z );
			
			// TO-DO: We can optimize our collision detection by only testing against sides
			// that oppose the direction in which we're moving.
			// This will reduce our testing calculations by about 50%.
			
			// Resolve collisions.
			var numCollisions:int = collisions.numCollisions;
			var face:FaceCollision;
			if ( numCollisions > 0 ) {
				for ( var i:int = 0; i < numCollisions; i++ ) {
					face = collisions.getAt( i );
					// If the player is moving up, hit the bottom sides of things.
					if ( playerModel.velocityY > 0 ) {
						if ( face.type == FaceTypes.BOTTOM ) {
							playerModel.velocityY = TrackConstants.BOUNCE_OFF_BOTTOM_VELOCITY;
							playerModel.positionY = ( playerModel.isDucking ) ? face.minY - TrackConstants.PLAYER_HALF_SIZE * .25 : face.minY - TrackConstants.PLAYER_HALF_SIZE;
						}
						playerModel.isAirborne = true;
					} else {
						// Else hit the top sides of things.
						if ( face.type == FaceTypes.TOP ) {
							if ( face.maxY > TrackConstants.CULL_FLOOR ) {
								playerModel.positionY = ( playerModel.isDucking ) ? face.maxY + TrackConstants.PLAYER_HALF_SIZE * .25 : face.maxY + TrackConstants.PLAYER_HALF_SIZE;
								playerModel.velocityY = 0;
								playerModel.isAirborne = false;
							} else {
								// The player is airborne if he's not colliding with a floor.
								playerModel.isAirborne = true;
							}
						}
					}
					// If we're moving left, hit the right sides of things.
					if ( playerModel.velocityX < 0 ) {
						if ( face.type == FaceTypes.RIGHT ) {
							
						}
					} else if ( playerModel.velocityX > 0 ) {
						// Else if we're moving right, hit the left sides of things.
						if ( face.type == FaceTypes.LEFT ) {
							
						}
					}
					// Always hit the front sides of things.
					if ( face.type == FaceTypes.FRONT ) {
						// Resolve this collision by moving the world.
						trackModel.move( face.minZ );
						playerModel.positionZ += -face.minZ;
						//distanceModel.add( -face.minZ );
						if ( face.event == CollisionTypes.SMACK ) {
							killPlayerRequest.dispatch( CollisionTypes.SMACK );
						}
					}
				}
			} else {
				// If we're not hitting something, we're airborne.
				playerModel.isAirborne = true;
				if ( playerModel.positionY < TrackConstants.FALL_DEATH_HEIGHT ) {
					if ( gameModel.gameState == GameState.WAITING_FOR_PLAYERS ) {
						resetPlayerRequest.dispatch();
					} else if ( gameModel.gameState == GameState.RUNNING ) {
						killPlayerRequest.dispatch( CollisionTypes.FALL );
					}
				}
			}
		}
	}
}
