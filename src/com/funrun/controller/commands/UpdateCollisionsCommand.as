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
			var targetInterpolationDist:Number = 100;
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
			trace("-- numSteps:",numSteps);
			if ( numSteps > 1 ) trace(" ====================================================================================================" );
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
						
						// For each block, for each face, solve the collision.
						var event:String;
						for ( var j:int = 0; j < blockIndices.length; j++ ) {
							bounds = segment.getBoundingBoxAt( blockIndices[ j ] ).add( segment ) as BoundingBoxVO;
							collisions = CollisionDetector.getCollidingFaces( collider, bounds );
							if ( CollisionDetector.doTheyIntersect( collider, bounds ) ) {
								// Only react to shallowest collision.
								var face:String = collisions.getAt( 0 );
								switch ( face ) {
									case Face.TOP:
										if ( playerModel.velocity.y <= 0 ) {
											event = bounds.block.getEventAtFace( face );
											if ( event == Collisions.WALK ) {
												collider.y = bounds.worldMaxY + Math.abs( collider.minY );
												playerModel.velocity.y = 0;
												playerModel.position.y = collider.y;
												playerModel.isAirborne = false;
												break;
											}
										}
									case Face.BOTTOM:
										if ( playerModel.velocity.y > 0 ) {
											break;
										}
									case Face.FRONT:
										if ( playerModel.velocity.z > 0 ) {
											event = bounds.block.getEventAtFace( face );
											if ( event == Collisions.SMACK ) {
												collider.z = bounds.worldMinZ + collider.minY;
												playerModel.velocity.z = Math.abs( playerModel.velocity.z ) * -.5;
												playerModel.position.z = collider.z;
												break;
											}
										}
								}
							}
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