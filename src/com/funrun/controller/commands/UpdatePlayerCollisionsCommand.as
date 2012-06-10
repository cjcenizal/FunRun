package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.DistanceModel;
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
		public var distanceModel:DistanceModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		// Commands.
		
		[Inject]
		public var killPlayerRequest:KillPlayerRequest;
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		override public function execute():void {
			
			// Collect all collisions.
			var collisions:CollisionsCollection = new CollisionsCollection();
			collisions.collectCollisions( trackModel, playerModel.mesh.x + playerModel.mesh.bounds.min.x, playerModel.mesh.y + playerModel.mesh.bounds.min.y, playerModel.mesh.z + playerModel.mesh.bounds.min.z, playerModel.mesh.x + playerModel.mesh.bounds.max.x, playerModel.mesh.y + playerModel.mesh.bounds.max.y, playerModel.mesh.z + playerModel.mesh.bounds.max.z );
			
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
					if ( playerModel.velocity.y > 0 ) {
						if ( face.type == FaceTypes.BOTTOM ) {
							playerModel.velocity.y = TrackConstants.BOUNCE_OFF_BOTTOM_VELOCITY;
							playerModel.mesh.y = ( playerModel.isDucking ) ? face.minY - TrackConstants.PLAYER_HALF_SIZE * .25 : face.minY - TrackConstants.PLAYER_HALF_SIZE;
						}
						playerModel.isAirborne = true;
					} else {
						// Else hit the top sides of things.
						if ( face.type == FaceTypes.TOP ) {
							if ( face.maxY > TrackConstants.CULL_FLOOR ) {
								playerModel.mesh.y = ( playerModel.isDucking ) ? face.maxY + TrackConstants.PLAYER_HALF_SIZE * .25 : face.maxY + TrackConstants.PLAYER_HALF_SIZE;
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
				if ( playerModel.mesh.y < TrackConstants.FALL_DEATH_HEIGHT ) {
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
