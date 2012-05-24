package com.funrun.model
{
	import away3d.entities.Mesh;
	
	import org.robotlegs.mvcs.Actor;
	
	public class PlayerModel extends Actor
	{
		// Player geometry.
		private var _player:Mesh;
		
		// State.
		public var speed:Number = 0;
		public var jumpVelocity:Number = 0;
		public var lateralVelocity:Number = 0;
		private var _isMovingLeft:Boolean = false;
		private var _isMovingRight:Boolean = false;
		public var isDucking:Boolean = false;
		public var isAirborne:Boolean = false;
		public var isDead:Boolean = false;
		public var isJumping:Boolean = false;
		
		public function PlayerModel()
		{
			super();
		}
		
		public function get player():Mesh {
			return _player;
		}
		
		public function set player( p:Mesh ):void {
			_player = p;
		}
		
		public function jump( speed:Number ):void {
			jumpVelocity += speed;
		}
		
		public function startMovingLeft( speed:Number ):void {
			if ( _isMovingRight ) {
				stopMovingRight( speed );
			}
			if ( !_isMovingLeft ) {
				lateralVelocity -= speed;
			}
			_isMovingLeft = true;
		}
		
		public function startMovingRight( speed:Number ):void {
			if ( _isMovingLeft ) {
				stopMovingLeft( speed );
			}
			if ( !_isMovingRight ) {
				lateralVelocity += speed;
			}
			_isMovingRight = true;
		}
		
		public function stopMovingLeft( speed:Number ):void {
			if ( _isMovingLeft ) {
				lateralVelocity += speed;
			}
			_isMovingLeft = false;
		}
		
		public function stopMovingRight( speed:Number ):void {
			if ( _isMovingRight ) {
				lateralVelocity -= speed;
			}
			_isMovingRight = false;
		}
		
		public function cancelMovement():void {
			_isMovingRight = _isMovingLeft = false;
		}
	}
}