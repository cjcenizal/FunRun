package com.funrun.controller.commands {
	
	import com.cenizal.physics.collisions.CollisionDetector;
	import com.cenizal.physics.collisions.Face;
	import com.cenizal.physics.collisions.FaceCollisionsVO;
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Collisions;
	import com.funrun.model.constants.Player;
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
			var targetInterpolationDist:Number = 100;
			var numSteps:Number = Math.ceil( playerModel.getDistanceFromPreviousPosition() / targetInterpolationDist );
			var interpolationVector:Vector3D = new Vector3D(
				( playerModel.position.x - initialPos.x ) / numSteps,
				( playerModel.position.y - initialPos.y ) / numSteps,
				1 / numSteps
			);
			
			var collider:CollidableVO = new CollidableVO();
			collider.copyFrom( ( playerModel.isDucking ) ? playerModel.duckingBounds : playerModel.normalBounds );
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
			for ( var n:int = 0; n < numSteps; n++ ) {
				var count:int = 0;
				var limit:int = 4;
				var segment:SegmentVO;
				var bounds:BoundingBoxVO;
				segments = trackModel.getObstacleArray();
				while ( count < limit ) {
					segmentIndices = CollisionDetector.getCollidingIndices( collider, segments );
					if ( segmentIndices.length == 0 ) {
						count = limit;
					} else {
						segment = trackModel.getObstacleAt( segmentIndices[ 0 ] );
						blocks = segment.getBoundingBoxes();
						blockIndices = CollisionDetector.getCollidingIndices( collider, blocks, segment );
						var event:String;
						bounds = segment.getBoundingBoxAt( blockIndices[ 0 ] ).add( segment ) as BoundingBoxVO;
						collisions = CollisionDetector.getCollidingFaces( collider, bounds );
						if ( collisions.count == 0 ) {
							count = limit;
						} else {
							if ( bounds.block.id == "floor" ) {
								// Just cheat floor collisions since we're falling through it randomly so often.
								collider.y = bounds.worldMaxY + Math.abs( collider.minY );
								playerModel.velocity.y = 0;
								playerModel.position.y = collider.y;
								playerModel.isOnTheGround = true;
							} else {
								n = numSteps; // We don't need to keep interpolating for collisions.
								if ( CollisionDetector.doTheyIntersect( collider, bounds ) ) {
									// Only react to shallowest collision.
									CollisionLoop: for ( var k:int = 0; k < collisions.count; k++ ) {
										var face:String = collisions.getAt( k );
										event = bounds.block.getEventAtFace( face );
										switch ( face ) {
											case Face.TOP:
												if ( playerModel.velocity.y <= 0 ) {
													if ( event == Collisions.WALK ) {
														collider.y = bounds.worldMaxY + Math.abs( collider.minY );
														playerModel.velocity.y = 0;
														playerModel.position.y = collider.y;
														playerModel.isOnTheGround = true;
														break CollisionLoop;
													} else if ( event == Collisions.JUMP ) {
														collider.y = bounds.worldMaxY + Math.abs( collider.minY );
														playerModel.velocity.y = Player.LAUNCH_SPEED;
														playerModel.position.y = collider.y;
														playerModel.isOnTheGround = true;
														break CollisionLoop;
													}
												}
											case Face.BOTTOM:
												if ( playerModel.velocity.y >= 0 ) {
													if ( event == Collisions.HIT ) {
														collider.y = bounds.worldMinY + collider.minY;
														playerModel.velocity.y = 0;
														playerModel.position.y = collider.y;
														break CollisionLoop;
													}
												}
											case Face.FRONT:
												if ( playerModel.velocity.z >= 0 ) {
													if ( event == Collisions.SMACK ) {
														collider.z = bounds.worldMinZ + collider.minY;
														playerModel.velocity.z = Math.abs( playerModel.velocity.z ) * -.5;
														playerModel.position.z = collider.z;
														break CollisionLoop;
													}
												}
											case Face.LEFT:
												if ( playerModel.velocity.x >= 0 ) {
													if ( event == Collisions.HIT ) {
														collider.x = bounds.worldMinX + collider.minX;
														playerModel.velocity.x = 0;
														playerModel.position.x = collider.x;
														break CollisionLoop;
													}
												}
											case Face.RIGHT:
												if ( playerModel.velocity.x <= 0 ) {
													if ( event == Collisions.HIT ) {
														collider.x = bounds.worldMaxX + Math.abs( collider.minX );
														playerModel.velocity.x = 0;
														playerModel.position.x = collider.x;
														break CollisionLoop;
													}
												}
										}
									}
								}
							}
							count++;
						}
					}
				}
				// Continue interpolation.
				collider.x += interpolationVector.x;
				collider.y += interpolationVector.y;
				collider.z += interpolationVector.z;
			}
		}
		
	}
}