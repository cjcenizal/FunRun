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
		private var _targetInterpolationDist:Number;
		private var _interpolationStepLimit:Number;
		private var _interpolationStepCount:int;
		private var _interpolationVector:Vector3D;
		private var _resolutionStepLimit:int = 4;
		private var _resolutionStepCount:int;
		private var _segmentsArr:Array;
		private var _collidingSegmentIndicesArr:Array;
		private var _firstCollidingSegment:SegmentVO;
		private var _firstCollidingSegmentBoundingBoxesArr:Array;
		private var _collidingBoundingBoxIndicesArr:Array;
		private var _firstCollidingBoundingBox:BoundingBoxVO;
		private var _collidingFaces:FaceCollisionsVO;
		private var _collidingFace:String;
		private var _collisionEvent:String;
		
		// Plan:
		// - X Translate vars to be local vars.
		// - X Break things out into smaller methods.
		// - > Step through logic to see where it breaks down.
		
		// Once fixed:
		// - Put floor back in SegmentsModel and StoreFloorCommand.
		// - Test quiitting a game and restarting; see if putting back "add floor" etc in ResetGameCommand matters.
		// - Test initial floor z in Segment.
		
		override public function execute():void {
			setupCollider();
			setupInterpolation();
			getAllSegments();
			
			// Interpolate the collider from previous position to current position.
			for ( _interpolationStepCount = 0; _interpolationStepCount < _interpolationStepLimit; _interpolationStepCount++ ) {
				
				resetResolutionStepCount();
				
				while ( _resolutionStepCount < _resolutionStepLimit ) {
					
					getCollidingSegmentIndices();
					
					if ( noCollidingSegments() ) {
						
						stopResolvingCollisions();
						
					} else {
						
						getFirstCollidingSegmentAndBoundingBoxes();
						getFirstCollidingBoundingBox();
						getFacesCollidingWithFirstBoundingBox();
						
						if ( noCollidingFaces() ) {
							
							stopResolvingCollisions();
						
						} else {
							
							stopInterpolating();
				//			if ( !CollisionDetector.doTheyIntersect( _collider, _firstCollidingBoundingBox ) ) trace( "===== ERROR WITH COLLISION DETECTION ======");
							
							// Only react to shallowest collision.
							CollisionLoop: for ( var k:int = 0; k < _collidingFaces.count; k++ ) {
								
								_collidingFace = _collidingFaces.getAt( k );
								
								getCollisionEventAtFirstCollidingBoundingBox();
								
								switch ( _collidingFace ) {
									case Face.TOP:
										if ( isTopCollision() ) break CollisionLoop;
									case Face.BOTTOM:
										if ( isBottomCollision() ) break CollisionLoop;
									case Face.FRONT:
										if ( isFrontCollision() ) break CollisionLoop;
									case Face.LEFT:
										if ( isLeftCollision() ) break CollisionLoop;
									case Face.RIGHT:
										if ( isRightCollision() ) break CollisionLoop;
								}
							}
							_resolutionStepCount++;
						}
					}
				}
				stepInterpolation();
			}
		}
		
		private function setupCollider():void {
			_collider = new CollidableVO();
			_collider.copyFrom( ( playerModel.isDucking ) ? playerModel.duckingBounds : playerModel.normalBounds );
		}
		
		private function setupInterpolation():void {
			// Interpolate half the side of the _collider's height, from its prev pos to its current pos.
			// TO-DO: Check this logic.
			_targetInterpolationDist = ( _collider.maxY - _collider.minY ) * .5;
			_interpolationStepLimit = Math.min( Math.ceil( playerModel.getDistanceFromPreviousPosition() / _targetInterpolationDist ), 5 );
			_interpolationVector = new Vector3D(
				( playerModel.position.x - playerModel.prevPosition.x ) / _interpolationStepLimit,
				( playerModel.position.y - playerModel.prevPosition.y ) / _interpolationStepLimit,
				( playerModel.position.z - playerModel.prevPosition.z ) / _interpolationStepLimit
			);
			if ( interpolationIsNecessary() ) {
				setColliderPositionTo( playerModel.prevPosition );
			} else {
				setColliderPositionTo( playerModel.position );
			}
		}
		
		private function getAllSegments():void {
			_segmentsArr = trackModel.getObstacleArray();
		}
		
		private function interpolationIsNecessary():Boolean {
			return ( _interpolationStepLimit > 1 );
		}
		
		private function setColliderPositionTo( pos:Vector3D ):void {
			_collider.x = pos.x;
			_collider.y = pos.y;
			_collider.z = pos.z;
		}
		
		private function resetResolutionStepCount():void {
			_resolutionStepCount = 0;
		}
		
		private function stopResolvingCollisions():void {
			_resolutionStepCount = _resolutionStepLimit;
		}
		
		private function stopInterpolating():void {
			_interpolationStepCount = _interpolationStepLimit;
		}
		
		private function getCollidingSegmentIndices():void {
			_collidingSegmentIndicesArr = CollisionDetector.getCollidingIndices( _collider, _segmentsArr );
		}
		
		private function noCollidingSegments():Boolean {
			return ( _collidingSegmentIndicesArr.length == 0 );
		}
		
		private function getFirstCollidingSegmentAndBoundingBoxes():void {
			_firstCollidingSegment = trackModel.getObstacleAt( _collidingSegmentIndicesArr[ 0 ] );
			_firstCollidingSegmentBoundingBoxesArr = _firstCollidingSegment.getBoundingBoxes();
			_collidingBoundingBoxIndicesArr = CollisionDetector.getCollidingIndices( _collider, _firstCollidingSegmentBoundingBoxesArr, _firstCollidingSegment ); // Why does this return blocks when it shouldn't? BUG HERE TOO I BET!
		}
		
		private function getFirstCollidingBoundingBox():void {	
			_firstCollidingBoundingBox = _firstCollidingSegment.getBoundingBoxAt( _collidingBoundingBoxIndicesArr[ 0 ] ).add( _firstCollidingSegment ) as BoundingBoxVO; // THE BUG IS HERE!
		}
		
		private function getFacesCollidingWithFirstBoundingBox():void {	
			_collidingFaces = CollisionDetector.getCollidingFaces( _collider, _firstCollidingBoundingBox );
		}
		
		private function noCollidingFaces():Boolean {
			return ( _collidingFaces.count == 0 );
		}
		
		private function getCollisionEventAtFirstCollidingBoundingBox():void {
			_collisionEvent = _firstCollidingBoundingBox.block.getEventAtFace( _collidingFace );
		}
		
		private function isTopCollision():Boolean {
			if ( playerModel.velocity.y <= 0 ) {
				if ( _collisionEvent == Collisions.WALK ) {
					_collider.y = _firstCollidingBoundingBox.worldMaxY + Math.abs( _collider.minY ) + 1;
					playerModel.velocity.y = 0;
					playerModel.position.y = _collider.y;
					playerModel.isOnTheGround = true;
					return true;
				} else if ( _collisionEvent == Collisions.JUMP ) {
					_collider.y = _firstCollidingBoundingBox.worldMaxY + Math.abs( _collider.minY );
					playerModel.velocity.y = Player.LAUNCH_SPEED;
					playerModel.position.y = _collider.y;
					playerModel.isOnTheGround = true;
					return true;
				}
			}
			return false;
		}
		
		private function isBottomCollision():Boolean {
			if ( playerModel.velocity.y >= 0 ) {
				if ( _collisionEvent == Collisions.HIT ) {
					_collider.y = _firstCollidingBoundingBox.worldMinY + _collider.minY;
					playerModel.velocity.y = 0;
					playerModel.position.y = _collider.y;
					return true;
				}
			}
			return false;
		}
		
		private function isFrontCollision():Boolean {
			if ( playerModel.velocity.z >= 0 ) {
				if ( _collisionEvent == Collisions.SMACK ) {
					_collider.z = _firstCollidingBoundingBox.worldMinZ + _collider.minY;
					playerModel.velocity.z = Math.abs( playerModel.velocity.z ) * -.5;
					playerModel.position.z = _collider.z;
					return true;
				}
			}
			return false;
		}
		
		private function isLeftCollision():Boolean {
			if ( playerModel.velocity.x >= 0 ) {
				if ( _collisionEvent == Collisions.HIT ) {
					_collider.x = _firstCollidingBoundingBox.worldMinX + _collider.minX;
					playerModel.velocity.x = 0;
					playerModel.position.x = _collider.x;
					return true;
				}
			}
			return false;
		}
		
		private function isRightCollision():Boolean {
			if ( playerModel.velocity.x <= 0 ) {
				if ( _collisionEvent == Collisions.HIT ) {
					_collider.x = _firstCollidingBoundingBox.worldMaxX + Math.abs( _collider.minX );
					playerModel.velocity.x = 0;
					playerModel.position.x = _collider.x;
					return true;
				}
			}
			return false;
		}
		
		private function stepInterpolation():void {
			_collider.x += _interpolationVector.x;
			_collider.y += _interpolationVector.y;
			_collider.z += _interpolationVector.z;
		}
	}
}