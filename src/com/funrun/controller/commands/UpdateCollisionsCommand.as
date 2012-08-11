package com.funrun.controller.commands {
	
	import com.cenizal.physics.collisions.Axis;
	import com.cenizal.physics.collisions.CollisionDetector;
	import com.cenizal.physics.collisions.Face;
	import com.cenizal.physics.collisions.FaceCollisionsVO;
	import com.cenizal.physics.collisions.ICollidable;
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Collisions;
	import com.funrun.model.constants.Player;
	import com.funrun.model.constants.Track;
	import com.funrun.model.state.GameState;
	import com.funrun.model.vo.BlockVO;
	import com.funrun.model.vo.BoundingBoxVO;
	import com.funrun.model.vo.CollidableVO;
	import com.funrun.model.vo.SegmentVO;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Interpolate a fixed distance from previous position
	 * to current position, performing collision detection
	 * along the way.
	 */
	public class UpdateCollisionsCommand extends Command {
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var gameState:GameState;
		
		// Commands.
		
		[Inject]
		public var killPlayerRequest:KillPlayerRequest;
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		override public function execute():void {
			var initialPos:Vector3D = playerModel.prevPosition.clone();
			var targetInterpolationDist:Number = 30;
			var numSteps:Number = Math.ceil( playerModel.getDistanceFromPreviousPosition() / targetInterpolationDist );
			var interpolationVector:Vector3D = new Vector3D(
				( playerModel.position.x - initialPos.x ) / numSteps,
				( playerModel.position.y - initialPos.y ) / numSteps,
				1 / numSteps
			);
			
			var collider:CollidableVO = new CollidableVO();
			collider.minX = playerModel.bounds.min.x;
			collider.minY = playerModel.bounds.min.y;
			collider.minZ = playerModel.bounds.min.z;
			collider.maxX = playerModel.bounds.max.x;
			collider.maxY = playerModel.bounds.max.y;
			collider.maxZ = playerModel.bounds.max.z;
			if ( numSteps == 1 ) {
				collider.x = playerModel.position.x;
				collider.y = playerModel.position.y;
				collider.z = playerModel.position.z;
			} else {
				collider.x = playerModel.prevPosition.x;
				collider.y = playerModel.prevPosition.y;
				collider.z = playerModel.prevPosition.z;
			}
			var segments:Array, blocks:Array, collisions:FaceCollisionsVO;
			var segmentIndices:Array, blockIndices:Array;
			trace("step")
			for ( var n:int = 0; n < numSteps; n++ ) {
				// Get all the segments we're colliding with.
				segments = trackModel.getObstacleArray();
				segmentIndices = CollisionDetector.getCollidingIndices( collider, segments );
				var segment:SegmentVO;
				var bounds:BoundingBoxVO;
				if ( segmentIndices.length == 0 ) {
					// If we're not hitting something, we're airborne.
					playerModel.isAirborne = true;
					if ( playerModel.position.y < Track.FALL_DEATH_HEIGHT ) {
						if ( gameState.gameState == GameState.WAITING_FOR_PLAYERS ) {
							resetPlayerRequest.dispatch();
						} else if ( gameState.gameState == GameState.RUNNING ) {
							killPlayerRequest.dispatch( Collisions.FALL );
						}
					}
				} else {
					// We have segments, so find block collisions.
					for ( var i:int = 0; i < segmentIndices.length; i++ ) {
						// Get all the blocks we're colliding with, sorted by collision volume, descending order.
						segment = trackModel.getObstacleAt( segmentIndices[ i ] );
						blocks = segment.getBoundingBoxes();
						blockIndices = CollisionDetector.getCollidingIndices( collider, blocks, segment );
						// Stop interpolation, because we've hit something here.
						if ( blockIndices.length > 0 ) n = numSteps;
						// Solve for y, z, and then x.
						solveForY( collider, blockIndices, segment );
						//solveForZ( collider, blockIndices, segment );
						//solveForX( collider, blockIndices, segment );
						playerModel.position.y = collider.y;
						
						//playerModel.position.x = collider.x;
						//playerModel.position.z = collider.z;
						
						
						
						/*
						for ( var j:int = 0; j < blockIndices.length; j++ ) {
							bounds = segment.getBoundingBoxAt( blockIndices[ j ] );
							// Get the faces we collide with most, sorted by collision axis, descending order.
							// For each of those faces, test if there is an event on that face.
							// If there is, resolve collision and react to event, and terminate the collision resolution.
							var collidee:BoundingBoxVO = bounds.add( segment ) as BoundingBoxVO;
							//trace(j,"block : (",collidee.worldMinX,collidee.worldMinY,collidee.worldMinZ,"), (",collidee.worldMaxX,collidee.worldMaxY,collidee.worldMaxZ,")");
							//trace("  player",collider.worldMinX,collider.worldMinY,collider.worldMinZ,"), (",collider.worldMaxX,collider.worldMaxY,collider.worldMaxZ,")");
							collisions = CollisionDetector.getCollidingFaces( collider, collidee );
							trace(collisions)
						}*/
					}
				}
				
				// Continue interpolation.
				collider.x += interpolationVector.x;
				collider.y += interpolationVector.y;
				collider.z += interpolationVector.z;
			}
		}
		
		
		private function solveForY( collider:ICollidable, blockIndices:Array, segment:SegmentVO ):void {
			var bounds:BoundingBoxVO;
			if ( playerModel.velocity.y > 0 ) {
				// If moving down, solve with collision for bottom.
				for ( var i:int = 0; i < blockIndices.length; i++ ) {
					bounds = segment.getBoundingBoxAt( blockIndices[ i ] ).add( segment ) as BoundingBoxVO;
					if ( CollisionDetector.collidesWithFace( collider, bounds, Face.BOTTOM ) ) {
						
					}
				}
			} else {
				// If moving down, solve with collision for top.
				for ( var i:int = 0; i < blockIndices.length; i++ ) {
					bounds = segment.getBoundingBoxAt( blockIndices[ i ] ).add( segment ) as BoundingBoxVO;
					if ( CollisionDetector.collidesWithFace( collider, bounds, Face.TOP ) ) {
						collider.y = bounds.worldMaxY + Math.abs( collider.minY );
						playerModel.velocity.y = 0;
						playerModel.isAirborne = false;
					}
				}
			}
		}
		
		private function solveForZ( collider:ICollidable, blockIndices:Array, segment:SegmentVO ):void {
			var bounds:BoundingBoxVO;
			if ( playerModel.velocity.z > 0 ) {
				// If moving forward, solve with collision for front.
				for ( var i:int = 0; i < blockIndices.length; i++ ) {
					bounds = segment.getBoundingBoxAt( blockIndices[ i ] ).add( segment ) as BoundingBoxVO;
					if ( CollisionDetector.collidesWithFace( collider, bounds, Face.FRONT ) ) {
					}
				}
			} else {
				// If moving down, solve with collision for back.
				for ( var i:int = 0; i < blockIndices.length; i++ ) {
					bounds = segment.getBoundingBoxAt( blockIndices[ i ] ).add( segment ) as BoundingBoxVO;
					if ( CollisionDetector.collidesWithFace( collider, bounds, Face.BACK ) ) {
						
					}
				}
			}
		}
		
		private function resolveCollisions( collider:ICollidable, segment:SegmentVO, bounds:BoundingBoxVO, collisions:FaceCollisionsVO ):Boolean {
			var axis:String;
			var event:String;
			trace(collisions)
			/*
			for ( var k:int = 0; k < collisions.faces.length; k++ ) {
				axis = collisions.axes[ k ];
				switch ( axis ) {
					case Axis.X:
						if ( collisions.contains( Face.LEFT ) ) {
							return true;
						} else if ( collisions.contains( Face.RIGHT ) ) {
							trace(Math.random(),"right");
							return true;
						}
						break;
					case Axis.Y:
						if ( collisions.contains( Face.TOP ) ) {
							event = bounds.block.getEventAtFace( Face.TOP );
							switch ( event ) {
								case Collisions.WALK:
									collider.y = playerModel.position.y = bounds.y + bounds.maxY + Player.HALF_HEIGHT;
									playerModel.velocity.y = 0;
									playerModel.isAirborne = false;
									break;
							}
							return true;
						} else if ( collisions.contains( Face.BOTTOM ) ) {
							return true;
						}
						break;
					case Axis.Z:
						if ( collisions.contains( Face.FRONT ) ) {
							event = bounds.block.getEventAtFace( Face.FRONT );
							switch ( event ) {
								case Collisions.SMACK:
									collider.z = playerModel.position.z = segment.z + bounds.z + bounds.minZ - Player.HALF_WIDTH;
									killPlayerRequest.dispatch( Collisions.SMACK );
									break;
							}
							return true;
						}
						break;
				}
			}*/
			
			
			return false;
			/*
			var face:String;
			for ( var k:int = 0; k < faces.faces.length; k++ ) {
				face = faces.faces[ k ];
				switch ( face ) {
					case Face.BOTTOM:
						if ( playerModel.velocityY > 0 ) {
							playerModel.velocityY = Track.BOUNCE_OFF_BOTTOM_VELOCITY;
							playerModel.positionY = block.y + block.minY;
							playerModel.isAirborne = true;
							break;
						}
					case Face.TOP:
						if ( playerModel.velocityY <= 0 ) {
							if ( block.block.getEventAtFace( face ) == Collisions.WALK ) {
								playerModel.positionY = block.y + block.maxY + Player.HALF_HEIGHT;
								playerModel.velocityY = 0;
								playerModel.isAirborne = false;
								break;
							}
						}
					case Face.FRONT:
						if ( block.block.getEventAtFace( face ) == Collisions.SMACK ) {
							playerModel.positionZ = segment.z + block.z + block.minZ - Player.HALF_WIDTH;
							killPlayerRequest.dispatch( Collisions.SMACK );
							break;
						}
					case Face.LEFT:
						break;
					case Face.RIGHT:
				}
			}*/
		}
		
		
		private function collide( collider:ICollidable, block:BoundingBoxVO, faces:FaceCollisionsVO ):void {
			
		}
	}
}