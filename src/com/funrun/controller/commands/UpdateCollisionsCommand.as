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
		
		// Local vars.
		
		private var _collider:CollidableVO;
		
		
		// Plan:
		// - Translate vars to be local vars.
		// - Break things out into smaller methods.
		// - Step through logic to see where it breaks down.
		// Once fixed:
		// - Put floor back in SegmentsModel and StoreFloorCommand.
		// - Test quiitting a game and restarting; see if putting back "add floor" etc in ResetGameCommand matters.
		// - Test initial floor z in Segment.
		
		override public function execute():void {
			_collider = new CollidableVO();
			_collider.copyFrom( ( playerModel.isDucking ) ? playerModel.duckingBounds : playerModel.normalBounds );
			
			// Interpolate half the side of the _collider's height, from its prev pos to its current pos.
			var targetInterpolationDist:Number = ( _collider.maxY - _collider.minY ) * .5;
			var numSteps:Number = Math.min( Math.ceil( playerModel.getDistanceFromPreviousPosition() / targetInterpolationDist ), 5 );
			var interpolationVector:Vector3D = new Vector3D(
				( playerModel.position.x - playerModel.prevPosition.x ) / numSteps,
				( playerModel.position.y - playerModel.prevPosition.y ) / numSteps,
				( playerModel.position.z - playerModel.prevPosition.z ) / numSteps
			);
			
			// If we aren't doing any interpolation, just set the _collider to the current position.
			if ( numSteps == 1 ) {
				_collider.x = playerModel.position.x;
				_collider.y = playerModel.position.y;
				_collider.z = playerModel.position.z;
			} else {
				_collider.x = playerModel.prevPosition.x;
				_collider.y = playerModel.prevPosition.y;
				_collider.z = playerModel.prevPosition.z;
			}
			
			var segments:Array, blocks:Array, collisions:FaceCollisionsVO;
			var segmentIndices:Array, blockIndices:Array;
			trace("-------------------------------------------------------");
			trace("_collider:", _collider);
			for ( var n:int = 0; n < numSteps; n++ ) {
				var count:int = 0;
				var limit:int = 4;
				var segment:SegmentVO;
				var bounds:BoundingBoxVO;
				segments = trackModel.getObstacleArray();
				while ( count < limit ) {
		//			trace("   count",count);
					segmentIndices = CollisionDetector.getCollidingIndices( _collider, segments );
					trace("segmentIndices",segmentIndices);
					if ( segmentIndices.length == 0 ) {
						// Terminate collision resolution.
						count = limit;
					} else {
						segment = trackModel.getObstacleAt( segmentIndices[ 0 ] );
						blocks = segment.getBoundingBoxes();
						blockIndices = CollisionDetector.getCollidingIndices( _collider, blocks, segment ); // Why does this return blocks when it shouldn't? BUG HERE TOO I BET!
						trace("blockIndices",blockIndices);
/*						if ( blockIndices.length > 0 ) {
							trace("blockIndices",blockIndices);
							for ( var i:int = 0; i < blockIndices.length; i++ ) {
								trace("    ",(segment.getBoundingBoxAt( blockIndices[ i ] ).add( segment ) as BoundingBoxVO));
								trace("    ",segment.getBoundingBoxAt( blockIndices[ i ] ).block);
							}
						}
						var event:String;
						bounds = segment.getBoundingBoxAt( blockIndices[ 0 ] ).add( segment ) as BoundingBoxVO; // THE BUG IS HERE!
						collisions = CollisionDetector.getCollidingFaces( _collider, bounds );
				//		trace("  ",collisions);
						if ( collisions.count == 0 ) {
							// Terminate collision resolution.
							count = limit;
						} else {
							n = numSteps; // We don't need to keep interpolating for collisions.
							if ( !CollisionDetector.doTheyIntersect( _collider, bounds ) ) trace( "===== ERROR WITH COLLISION DETECTION ======");
							// Only react to shallowest collision.
							CollisionLoop: for ( var k:int = 0; k < collisions.count; k++ ) {
								var face:String = collisions.getAt( k );
								event = bounds.block.getEventAtFace( face );
				//				trace("     colliding with " + face + ", event:",event);
								switch ( face ) {
									case Face.TOP:
										if ( playerModel.velocity.y <= 0 ) {
											if ( event == Collisions.WALK ) {
												trace("         walk");
												_collider.y = bounds.worldMaxY + Math.abs( _collider.minY ) + 1;
												playerModel.velocity.y = 0;
												playerModel.position.y = _collider.y;
												playerModel.isOnTheGround = true;
												break CollisionLoop;
											} else if ( event == Collisions.JUMP ) {
				//								trace("         jump");
												_collider.y = bounds.worldMaxY + Math.abs( _collider.minY );
												playerModel.velocity.y = Player.LAUNCH_SPEED;
												playerModel.position.y = _collider.y;
												playerModel.isOnTheGround = true;
												break CollisionLoop;
											}
										}
									case Face.BOTTOM:
										if ( playerModel.velocity.y >= 0 ) {
											if ( event == Collisions.HIT ) {
				//								trace("         hit");
												_collider.y = bounds.worldMinY + _collider.minY;
												playerModel.velocity.y = 0;
												playerModel.position.y = _collider.y;
												break CollisionLoop;
											}
										}
									case Face.FRONT:
										if ( playerModel.velocity.z >= 0 ) {
											if ( event == Collisions.SMACK ) {
												trace("         smack");
												_collider.z = bounds.worldMinZ + _collider.minY;
												playerModel.velocity.z = Math.abs( playerModel.velocity.z ) * -.5;
												playerModel.position.z = _collider.z;
												break CollisionLoop;
											}
										}
									case Face.LEFT:
										if ( playerModel.velocity.x >= 0 ) {
											if ( event == Collisions.HIT ) {
				//								trace("         hit left");
												_collider.x = bounds.worldMinX + _collider.minX;
												playerModel.velocity.x = 0;
												playerModel.position.x = _collider.x;
												break CollisionLoop;
											}
										}
									case Face.RIGHT:
										if ( playerModel.velocity.x <= 0 ) {
											if ( event == Collisions.HIT ) {
				//								trace("         hit right");
												_collider.x = bounds.worldMaxX + Math.abs( _collider.minX );
												playerModel.velocity.x = 0;
												playerModel.position.x = _collider.x;
												break CollisionLoop;
											}
										}
								}
							}
							count++;
						}*/
					}
				}
				// Continue interpolation.
				_collider.x += interpolationVector.x;
				_collider.y += interpolationVector.y;
				_collider.z += interpolationVector.z;
			}
			
	//		trace("pos: " + playerModel.position.y);
		}
		
	}
}