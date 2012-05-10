package com.funrun.game.model
{
	import away3d.entities.Mesh;
	
	import org.robotlegs.mvcs.Actor;
	
	public class PlayerModel extends Actor
	{
		// Player geometry.
		private var _player:Mesh;
		
		// State.
		private var _jumpVelocity:Number = 0;
		private var _lateralVelocity:Number = 0;
		private var _isJumping:Boolean = false;
		private var _isMovingLeft:Boolean = false;
		private var _isMovingRight:Boolean = false;
		private var _isDucking:Boolean = false;
		private var _isAirborne:Boolean = false;
		
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
			if ( !_isJumping ) {
				_jumpVelocity += speed;
			}
			_isJumping = true;
		}
		
		public function stopJumping():void {
			_isJumping = false;
		}
		
		public function startMovingLeft( speed:Number ):void {
			if ( _isMovingRight ) {
				stopMovingRight( speed );
			}
			if ( !_isMovingLeft ) {
				_lateralVelocity -= speed;
			}
			_isMovingLeft = true;
		}
		
		public function startMovingRight( speed:Number ):void {
			if ( _isMovingLeft ) {
				stopMovingLeft( speed );
			}
			if ( !_isMovingRight ) {
				_lateralVelocity += speed;
			}
			_isMovingRight = true;
		}
		
		public function startDucking():void {
			_isDucking = true;
		}
		
		public function stopMovingLeft( speed:Number ):void {
			if ( _isMovingLeft ) {
				_lateralVelocity += speed;
			}
			_isMovingLeft = false;
		}
		
		public function stopMovingRight( speed:Number ):void {
			if ( _isMovingRight ) {
				_lateralVelocity -= speed;
			}
			_isMovingRight = false;
		}
		
		public function stopDucking():void {
			_isDucking = false;
		}
		
		public function get isJumping():Boolean {
			return _isJumping;
		}
		
		public function get isAirborne():Boolean {
			return _isAirborne;
		}
		
		public function get lateralVelocity():Number {
			return _lateralVelocity;
		}
		
		public function get jumpVelocity():Number {
			return _jumpVelocity;
		}
		
		public function set jumpVelocity( val:Number ):void {
			_jumpVelocity = val;
		}
		
		public function set isAirborne( val:Boolean ):void {
			_isAirborne = val;
		}
	}
}