package com.funrun.controller.commands {
	
	import com.cenizal.physics.collisions.CollisionDetector;
	import com.cenizal.physics.collisions.ICollidable;
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.GameModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Collisions;
	import com.funrun.model.constants.FaceTypes;
	import com.funrun.model.constants.Track;
	import com.funrun.model.state.GameState;
	import com.funrun.model.vo.BlockVO;
	import com.funrun.model.vo.BoundingBoxVO;
	import com.funrun.model.vo.CollidableVO;
	import com.funrun.model.vo.SegmentVO;
	
	import flash.geom.Vector3D;
	
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
		
		
		
		// TO-DO: Figure out why this is necessary. It's probably due to the way the model is being
		// treated in relation to its position. Then figure out how to fix it so this magic # isn't needed.
		private var playerVerticalOffset:Number = 150;
		
		
		override public function execute():void {
			// Interpolate a fixed distance from previous position
			// to current position, performing collision detection
			// along the way. Exit loop as soon as a collision
			// is detected.
			
			
			var testPos:Vector3D = playerModel.getPreviousPositionClone();
			var targetInterpolationDist:Number = Block.SIZE;
			var numSteps:Number = Math.ceil( playerModel.getDistanceFromPreviousPosition() / targetInterpolationDist );
			var interpolationVector:Vector3D = new Vector3D(
				( playerModel.positionX - testPos.x ) / numSteps,
				( playerModel.positionY - testPos.y ) / numSteps,
				1 / numSteps
			);
			
			if ( numSteps == 1 ) {
				testPos.x = playerModel.positionX;
				testPos.y = playerModel.positionY;
				testPos.z = playerModel.positionZ;
			}
			var collider:CollidableVO = new CollidableVO();
			collider.minX = playerModel.bounds.min.x;
			collider.minY = playerModel.bounds.min.y;
			collider.minZ = playerModel.bounds.min.z;
			collider.maxX = playerModel.bounds.max.x;
			collider.maxY = playerModel.bounds.max.y;
			collider.maxZ = playerModel.bounds.max.z;
			var segments:Array, blocks:Array, faces:Array;
			var segmentIndices:Array, blockIndices:Array;
			for ( var n:int = 0; n < numSteps; n++ ) {
				collider.x = testPos.x;
				collider.y = testPos.y - playerVerticalOffset;
				collider.z = testPos.z;
				// Get all the segments we're colliding with.
				segments = trackModel.getObstacleArray();
				segmentIndices = CollisionDetector.getCollidingIndices( collider, segments );
				var segment:SegmentVO;
				for ( var i:int = 0; i < segmentIndices.length; i++ ) {
					segment = trackModel.getObstacleAt( segmentIndices[ i ] );
					blocks = segment.getBoundingBoxes();
					// Recursively resolve each collision with the blocks of a segment.
					while ( !resolved( collider, segment, blocks ) ) {
					}
				}
				testPos.x += interpolationVector.x;
				testPos.y += interpolationVector.y;
				testPos.z += interpolationVector.z;
			}
		}
		
		private function resolved( collider:ICollidable, segment:SegmentVO, blocks:Array, count:int = 0 ):Boolean {
			if ( count >= 5 ) {
				// Terminate recursion after 5 iterations.
				return true;
			}
			// Get all the blocks we're colliding with.
			var blockIndices:Array = CollisionDetector.getCollidingIndices( collider, blocks, segment );
			var block:BoundingBoxVO;
			var faces:Array;
			for ( var j:int = 0; j < blockIndices.length; j++ ) {
				block = segment.getBoundingBoxAt( blockIndices[ j ] );
				// Get the faces we're colliding with.
				faces = CollisionDetector.getCollidingFaces( collider, block.add( segment ) );
				var face:String;
				for ( var k:int = 0; k < faces.length; k++ ) {
					face = faces[ k ];
					// React to collisions with various faces.
					switch ( face ) {
						case CollisionDetector.BOTTOM:
							if ( playerModel.velocityY > 0 ) {
								playerModel.velocityY = Track.BOUNCE_OFF_BOTTOM_VELOCITY;
								playerModel.positionY = block.y + block.minY;//( playerModel.isDucking ) ? face.minY - Track.PLAYER_HALF_SIZE * .25 : face.minY - Track.PLAYER_HALF_SIZE;
								playerModel.isAirborne = true;
								collider.y = playerModel.positionY - playerVerticalOffset;
								return resolved( collider, segment, blocks, count + 1 );
							}
						case CollisionDetector.TOP:
							if ( playerModel.velocityY <= 0 && block.block.getEventAtFace( face ) == Collisions.WALK) {
								playerModel.positionY = block.y + block.maxY + playerVerticalOffset;// face.maxY + 150;//( playerModel.isDucking ) ? face.maxY + Track.PLAYER_HALF_SIZE * .25 : face.maxY + Track.PLAYER_HALF_SIZE;
								playerModel.velocityY = 0;
								playerModel.isAirborne = false;
								collider.y = playerModel.positionY - playerVerticalOffset;
								return resolved( collider, segment, blocks, count + 1 );
							}
					}
					switch ( face ) {
						case CollisionDetector.FRONT:
							playerModel.positionZ += block.minZ - Track.PLAYER_HALF_SIZE;
							collider.z = playerModel.positionZ;
							if ( block.block.getEventAtFace( face ) == Collisions.SMACK ) {
								killPlayerRequest.dispatch( Collisions.SMACK );
								return true;
							}
							return resolved( collider, segment, blocks, count + 1 );
						/*case CollisionDetector.LEFT:
							return resolved( collider, segment, blocks, count + 1 );
						case CollisionDetector.RIGHT:
							return resolved( collider, segment, blocks, count + 1 );*/
					}
				}
			}
			return true;
		}
		
		/*
		collisions.collectCollisions(
			trackModel,
			testPos.x + playerModel.bounds.min.x,
			testPos.y + playerModel.bounds.min.y,
			testPos.z + playerModel.bounds.min.z,
			testPos.x + playerModel.bounds.max.x,
			testPos.y + playerModel.bounds.max.y,
			testPos.z + playerModel.bounds.max.z );
				
				// TO-DO: We can optimize our collision detection by only testing against sides
				// that oppose the direction in which we're moving.
				// This will reduce our testing calculations by about 50%.
				
				// Resolve collisions.
				
				var numCollisions:int = collisions.numCollisions;
		var face:FaceCollision;
		trace("collide " + numCollisions);
		if ( numCollisions > 0 ) {
			for ( var i:int = 0; i < numCollisions; i++ ) {
				face = collisions.getAt( i );
				trace("  " + face.type);
				// If the player is moving up, hit the bottom sides of things.
				if ( playerModel.velocityY > 0 ) {
					if ( face.type == FaceTypes.BOTTOM ) {
						playerModel.velocityY = Track.BOUNCE_OFF_BOTTOM_VELOCITY;
						playerModel.positionY = ( playerModel.isDucking ) ? face.minY - Track.PLAYER_HALF_SIZE * .25 : face.minY - Track.PLAYER_HALF_SIZE;
						return;
					}
					playerModel.isAirborne = true;
				} else {
					// Else hit the top sides of things.
					if ( face.type == FaceTypes.TOP ) {
						// TO-DO: What is CULL_FLOOR and why is this here?
						//if ( face.maxY > Track.CULL_FLOOR ) {
						playerModel.positionY = face.maxY + 150;//( playerModel.isDucking ) ? face.maxY + Track.PLAYER_HALF_SIZE * .25 : face.maxY + Track.PLAYER_HALF_SIZE;
						playerModel.velocityY = 0;
						playerModel.isAirborne = false;
						return;
						//} else {
						// The player is airborne if he's not colliding with a floor.
						//	playerModel.isAirborne = true;
						//}
					}
				}
				// If we're moving left, hit the right sides of things.
				if ( playerModel.velocityX < 0 ) {
					if ( face.type == FaceTypes.RIGHT ) {
						return;
					}
				} else if ( playerModel.velocityX > 0 ) {
					// Else if we're moving right, hit the left sides of things.
					if ( face.type == FaceTypes.LEFT ) {
						return;
					}
				}
				// Always hit the front sides of things.
				if ( face.type == FaceTypes.FRONT ) {
					// Resolve this collision.
					playerModel.positionZ = face.minZ - Track.PLAYER_HALF_SIZE;
					if ( face.event == CollisionTypes.SMACK ) {
						killPlayerRequest.dispatch( CollisionTypes.SMACK );
					}
					return;
				}
			}
		} else {
			// If we're not hitting something, we're airborne.
			playerModel.isAirborne = true;
			if ( playerModel.positionY < Track.FALL_DEATH_HEIGHT ) {
				if ( gameModel.gameState == GameState.WAITING_FOR_PLAYERS ) {
					resetPlayerRequest.dispatch();
				} else if ( gameModel.gameState == GameState.RUNNING ) {
					killPlayerRequest.dispatch( CollisionTypes.FALL );
				}
			}
		}
		*/
	}
}