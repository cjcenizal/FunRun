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
		private var _interpolationStepDistance:Number;
		private var _numberOfStepsToInterpolate:Number = 5;
		private var _interpolationStepCount:int;
		private var _interpolationVector:Vector3D;
		private var _numberOfStepsToResolveCollisions:int = 4;
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
		
		// Secondary:
		// - Test the frame interpolation algo and figure out how it imapcts this algo and can cause a positive feedback loop.
		
		// Once fixed:
		// - Put floor back in SegmentsModel and StoreFloorCommand.
		// - Test quiitting a game and restarting; see if putting back "add floor" etc in ResetGameCommand matters.
		// - Test initial floor z in Segment.
		
		override public function execute():void {
			setupCollider();
			setupInterpolation();
			getAllSegments();
			
			// Interpolate the collider from previous position to current position.
			for ( _interpolationStepCount = 0; _interpolationStepCount < _numberOfStepsToInterpolate; _interpolationStepCount++ ) {
				
				stepInterpolation();
				resetResolution();
				
				// Resolve collisions.
				while ( _resolutionStepCount < _numberOfStepsToResolveCollisions ) {
					// OK.
					getCollidingSegmentIndices();
					
					if ( noCollidingSegments() ) {
						stopResolvingCollisions();	
					} else {
						
						// Suspect, but seems to be fixed now.
						getFirstCollidingSegment();
						getCollidingBoundingBoxes();
						
						if ( noCollidingBoundingBoxes() ) {
							stopResolvingCollisions();
						} else {
							
							getFirstCollidingBoundingBox();
							getFacesCollidingWithFirstBoundingBox();
							
							if ( noCollidingFaces() ) {
								stopResolvingCollisions();
							
							} else {
								stopInterpolating();
								
								// Only react to shallowest collision.
								CollisionLoop: for ( var k:int = 0; k < _collidingFaces.count; k++ ) {
									
									_collidingFace = _collidingFaces.getAt( k );
									
									getCollisionEventAtFirstCollidingBoundingBox();
									
									switch ( _collidingFace ) {
										case Face.TOP:
											if ( isTopCollision() ) {
												break CollisionLoop;
											}
										case Face.BOTTOM:
											if ( isBottomCollision() ) {
												break CollisionLoop;
											}
										case Face.FRONT:
											if ( isFrontCollision() ) {
												break CollisionLoop;
											}
										case Face.LEFT:
											if ( isLeftCollision() ) {
												break CollisionLoop;
											}
										case Face.RIGHT:
											if ( isRightCollision() ){
												break CollisionLoop;
											}
									}
								}
							}
						}
					}
					stepResolution();
				}
			}
		}
		
		private function setupCollider():void {
			_collider = new CollidableVO();
			_collider.copyFrom( ( playerModel.isDucking ) ? playerModel.duckingBounds : playerModel.normalBounds );
		}
		
		private function setupInterpolation():void {
			// Use the collider's height as the yardstick for interpolation.
			_interpolationStepDistance = ( _collider.maxY - _collider.minY ) * .5;
			var distanceTraveled:Number = playerModel.getDistanceFromPreviousPosition();
			if ( distanceTraveled == 0 ) {
				// If we haven't traveled any distance, then we don't need to resolve any collisions and we can go home.
				_numberOfStepsToInterpolate = 1;
				stopInterpolating();
				stopResolvingCollisions();
			} else {
				_numberOfStepsToInterpolate = Math.ceil( distanceTraveled / _interpolationStepDistance );
			}
			if ( interpolationIsNecessary() ) {
				// Prepare to interpolate.
				setColliderPositionTo( playerModel.prevPosition );
				_interpolationVector = new Vector3D(
					( playerModel.position.x - playerModel.prevPosition.x ) / _numberOfStepsToInterpolate,
					( playerModel.position.y - playerModel.prevPosition.y ) / _numberOfStepsToInterpolate,
					( playerModel.position.z - playerModel.prevPosition.z ) / _numberOfStepsToInterpolate
				);
			} else {
				// Don't interpolate, just use the current player's position.
				setColliderPositionTo( playerModel.position );
				_interpolationVector = new Vector3D();
			}
		}
		
		private function getAllSegments():void {
			_segmentsArr = trackModel.getObstacleArray();
		}
		
		private function interpolationIsNecessary():Boolean {
			return ( _numberOfStepsToInterpolate > 1 );
		}
		
		private function setColliderPositionTo( pos:Vector3D ):void {
			_collider.x = pos.x;
			_collider.y = pos.y;
			_collider.z = pos.z;
		}
		
		private function resetResolution():void {
			_resolutionStepCount = 0;
			_numberOfStepsToResolveCollisions = 4;
		}
		
		private function stepResolution():void {
			_resolutionStepCount++;
		}
		
		private function stopResolvingCollisions():void {
			_numberOfStepsToResolveCollisions = 0;
		}
		
		private function stopInterpolating():void {
			_numberOfStepsToInterpolate = 0;
		}
		
		private function getCollidingSegmentIndices():void {
			_collidingSegmentIndicesArr = CollisionDetector.getCollidingIndices( _collider, _segmentsArr );
		}
		
		private function noCollidingSegments():Boolean {
			return ( _collidingSegmentIndicesArr.length == 0 );
		}
		
		private function getFirstCollidingSegment():void {
			_firstCollidingSegment = trackModel.getObstacleAt( _collidingSegmentIndicesArr[ 0 ] );
		}
		
		private function getCollidingBoundingBoxes():void {
			_firstCollidingSegmentBoundingBoxesArr = _firstCollidingSegment.getBoundingBoxes();
			_collidingBoundingBoxIndicesArr = CollisionDetector.getCollidingIndices( _collider, _firstCollidingSegmentBoundingBoxesArr, _firstCollidingSegment );
		}
		
		private function noCollidingBoundingBoxes():Boolean {
			return ( _collidingBoundingBoxIndicesArr.length == 0 );
		}
		
		private function getFirstCollidingBoundingBox():void {
			_firstCollidingBoundingBox = _firstCollidingSegment.getBoundingBoxAt( _collidingBoundingBoxIndicesArr[ 0 ] ).add( _firstCollidingSegment ) as BoundingBoxVO;
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
					_collider.y = _firstCollidingBoundingBox.worldMaxY + Math.abs( _collider.minY );
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