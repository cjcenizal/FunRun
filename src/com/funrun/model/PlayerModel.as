package com.funrun.model {

	import away3d.entities.Mesh;

	import flash.geom.Vector3D;

	import org.robotlegs.mvcs.Actor;

	public class PlayerModel extends Actor {
		
		// Player geometry.
		private var _mesh:Mesh;

		// State.
		public var velocity:Vector3D;
		public var isDucking:Boolean = false;
		public var isAirborne:Boolean = false;
		public var isDead:Boolean = false;
		public var isJumping:Boolean = false;
		private var _isMovingLeft:Boolean = false;
		private var _isMovingRight:Boolean = false;

		public function PlayerModel() {
			super();
			velocity = new Vector3D();
		}

		public function get mesh():Mesh {
			return _mesh;
		}

		public function set mesh( m:Mesh ):void {
			_mesh = m;
		}

		public function jump( speed:Number ):void {
			velocity.y += speed;
		}

		public function startMovingLeft( speed:Number ):void {
			if ( _isMovingRight ) {
				stopMovingRight( speed );
			}
			if ( !_isMovingLeft ) {
				velocity.x -= speed;
			}
			_isMovingLeft = true;
		}

		public function startMovingRight( speed:Number ):void {
			if ( _isMovingLeft ) {
				stopMovingLeft( speed );
			}
			if ( !_isMovingRight ) {
				velocity.x += speed;
			}
			_isMovingRight = true;
		}

		public function stopMovingLeft( speed:Number ):void {
			if ( _isMovingLeft ) {
				velocity.x += speed;
			}
			_isMovingLeft = false;
		}

		public function stopMovingRight( speed:Number ):void {
			if ( _isMovingRight ) {
				velocity.x -= speed;
			}
			_isMovingRight = false;
		}

		public function cancelMovement():void {
			_isMovingRight = _isMovingLeft = false;
		}
	}
}
