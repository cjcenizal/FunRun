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
	public class UpdatePlayerCollisionsCommand extends Command {
		
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
			var segments:Array, blocks:Array, faces:FaceCollisionsVO;
			var segmentIndices:Array, blockIndices:Array;
			for ( var n:int = 0; n < numSteps; n++ ) {
				collider.x = testPos.x;
				collider.y = testPos.y;
				collider.z = testPos.z;
				// Get all the segments we're colliding with.
				segments = trackModel.getObstacleArray();
				segmentIndices = CollisionDetector.getCollidingIndices( collider, segments );
				var segment:SegmentVO;
				for ( var i:int = 0; i < segmentIndices.length; i++ ) {
					segment = trackModel.getObstacleAt( segmentIndices[ i ] );
					
					// Get all the blocks we're colliding with.
					
					// Get the blocks we collide with most.
					
					// For each of those blocks, get the faces we collide with most.
					
					// For each of those faces, test if there is an event on that face.
					
					// If there is, resolve collision and react to event, and terminate.
					
					// Else, continue.
					
					blocks = segment.getBoundingBoxes();
					blockIndices = CollisionDetector.getCollidingIndices( collider, blocks, segment );
					var block:BoundingBoxVO;
					for ( var j:int = 0; j < blockIndices.length; j++ ) {
						block = segment.getBoundingBoxAt( blockIndices[ j ] );
						// Get the faces we're colliding with.
						faces = CollisionDetector.getCollidingFaces( collider, block.add( segment ) );
						collide( collider, block, faces );
						
						/*
						var face:String;
						for ( var k:int = 0; k < faces.length; k++ ) {
							face = faces[ k ];
							// React to collisions with various faces.
							// - If we land on top of a walkable block, walk on it.
							// - If we run into the front of a smacking block, die.
							// TO-DO: Detect which face the COLLIDER is colliding with, too.
							switch ( face ) {
								case CollisionDetector.BOTTOM:
									if ( playerModel.velocityY > 0 ) {
										playerModel.velocityY = Track.BOUNCE_OFF_BOTTOM_VELOCITY;
										playerModel.positionY = block.y + block.minY;
										playerModel.isAirborne = true;
										break;
									}
								case CollisionDetector.TOP:
									if ( playerModel.velocityY <= 0 ) {
										if ( block.block.getEventAtFace( face ) == Collisions.WALK ) {
											playerModel.positionY = block.y + block.maxY + Player.HALF_HEIGHT;
											playerModel.velocityY = 0;
											playerModel.isAirborne = false;
											break;
										}
									}
								case CollisionDetector.FRONT:
									if ( block.block.getEventAtFace( face ) == Collisions.SMACK ) {
										playerModel.positionZ = segment.z + block.z + block.minZ - Player.HALF_WIDTH;
										killPlayerRequest.dispatch( Collisions.SMACK );
										break;
									}
								case CollisionDetector.LEFT:
									break;
								case CollisionDetector.RIGHT:
							}
						}*/
					}
				}
				if ( segmentIndices.length == 0 ) {
					// If we're not hitting something, we're airborne.
					playerModel.isAirborne = true;
					if ( playerModel.positionY < Track.FALL_DEATH_HEIGHT ) {
						if ( gameState.gameState == GameState.WAITING_FOR_PLAYERS ) {
							resetPlayerRequest.dispatch();
						} else if ( gameState.gameState == GameState.RUNNING ) {
							killPlayerRequest.dispatch( Collisions.FALL );
						}
					}
				}
				testPos.x += interpolationVector.x;
				testPos.y += interpolationVector.y;
				testPos.z += interpolationVector.z;
			}
		}
		
		
		private function collide( collider:ICollidable, block:BoundingBoxVO, faces:FaceCollisionsVO ):void {
			var axis:String;
			for ( var k:int = 0; k < faces.faces.length; k++ ) {
				axis = faces.axes[ k ];
				switch ( axis ) {
					case Axis.X:
					if ( faces.contains( Face.LEFT ) ) {
						
						return;
					} else if ( faces.contains( Face.RIGHT ) ) {
						return;
					}
					break;
					case Axis.Y:
					break;
					case Axis.Z:
					break;
				}
			}
		}
	}
}