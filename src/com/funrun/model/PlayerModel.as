package com.funrun.model {

	import away3d.bounds.BoundingVolumeBase;
	import away3d.entities.Mesh;
	
	import com.cenizal.utils.Numbers;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.PlayerProperties;
	import com.funrun.model.vo.IPlaceable;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;

	public class PlayerModel extends Actor implements IPlaceable {
		
		// Player geometry.
		private var _mesh:Mesh;
		
		// Player properties.
		public var userId:String;
		public var name:String;
		private var _inGameId:int;
		private var _properties:Object;
		
		// Physical state.
		private var _position:Vector3D;
		private var _prevPosition:Vector3D;
		private var _velocity:Vector3D;
		private var _isMovingLeft:Boolean = false;
		private var _isMovingRight:Boolean = false;
		private var _place:int = 0;
		public var isDucking:Boolean = false;
		public var isAirborne:Boolean = false;
		public var isDead:Boolean = false;
		public var isJumping:Boolean = false;

		public function PlayerModel() {
			super();
			_properties = {};
			_velocity = new Vector3D();
			_position = new Vector3D();
			_prevPosition = new Vector3D();
			resetInGameId();
		}
		
		public function resetInGameId():void {
			_inGameId = -1;
		}
		
		public function startMovingLeft( speed:Number ):void {
			if ( _isMovingRight ) {
				stopMovingRight( speed );
			}
			if ( !_isMovingLeft ) {
				_velocity.x -= speed;
			}
			_isMovingLeft = true;
		}

		public function startMovingRight( speed:Number ):void {
			if ( _isMovingLeft ) {
				stopMovingLeft( speed );
			}
			if ( !_isMovingRight ) {
				_velocity.x += speed;
			}
			_isMovingRight = true;
		}

		public function stopMovingLeft( speed:Number ):void {
			if ( _isMovingLeft ) {
				_velocity.x += speed;
			}
			_isMovingLeft = false;
		}

		public function stopMovingRight( speed:Number ):void {
			if ( _isMovingRight ) {
				_velocity.x -= speed;
			}
			_isMovingRight = false;
		}

		public function cancelMovement():void {
			_isMovingRight = _isMovingLeft = false;
		}
		
		public function getPositionClone():Vector3D {
			return _position.clone();
		}
		
		public function getPreviousPositionClone():Vector3D {
			return _prevPosition.clone();
		}
		
		public function getDistanceFromPreviousPosition():Number {
			return _position.subtract( _prevPosition ).length;
		}
		
		public function updateMeshPosition():void {
			_mesh.x = _position.x;
			_mesh.y = _position.y;
			_mesh.z = _position.z;
			_prevPosition.x = _position.x;
			_prevPosition.y = _position.y;
			_prevPosition.z = _position.z;
		}
		
		public function getMeshPosition():Vector3D {
			return _mesh.position;
		}
		
		public function get distance():Number {
			return _position.z;
		}
		
		public function get distanceInFeet():int {
			return Math.round( distance / Block.SIZE );
		}
		
		public function get distanceString():String {
			return Numbers.addCommasTo( distanceInFeet.toString() );
		}
		
		public function set place( val:int ):void {
			_place = val;
		}
		
		public function get place():int {
			return _place;
		}
		
		public function set mesh( m:Mesh ):void {
			_mesh = m;
		}
		
		public function get velocityX():Number {
			return _velocity.x;
		}
		
		public function get velocityY():Number {
			return _velocity.y;
		}
		
		public function get velocityZ():Number {
			return _velocity.z;
		}
		
		public function set velocityX( value:Number ):void {
			_velocity.x = value;
		}
		
		public function set velocityY( value:Number ):void {
			_velocity.y = value;
		}
		
		public function set velocityZ( value:Number ):void {
			_velocity.z = value;
		}
		
		public function get positionX():Number {
			return _position.x;
		}
		
		public function get positionY():Number {
			return _position.y;
		}
		
		public function get positionZ():Number {
			return _position.z;
		}
		
		public function set positionX( value:Number ):void {
			_position.x = value;
		}
		
		public function set positionY( value:Number ):void {
			_position.y = value;
		}
		
		public function set positionZ( value:Number ):void {
			_position.z = value;
		}
		
		public function get bounds():BoundingVolumeBase {
			return _mesh.bounds;
		}
		
		public function get scaleY():Number {
			return _mesh.scaleY;
		}
		
		public function set scaleY( value:Number ):void {
			_mesh.scaleY = value;
		}
		
		public function set inGameId( val:int ) {
			_inGameId = val;
		}
		
		public function get inGameId():int {
			return _inGameId;
		}
		
		public function get properties():Object {
			return _properties;
		}
		
		public function get bestDistance():Number {
			return _properties[ PlayerProperties.BEST_DISTANCE ];
		}
		
		public function set bestDistance( val:Number ) {
			_properties[ PlayerProperties.BEST_DISTANCE ] = val;
		}
		
		public function get points():Number {
			return _properties[ PlayerProperties.POINTS ];
		}
		
		public function set points( val:Number ) {
			_properties[ PlayerProperties.POINTS ] = val;
		}
	}
}
