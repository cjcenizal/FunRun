package com.funrun.model
{
	import away3d.entities.Mesh;
	
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Actor;
	
	public class MouseModel extends Actor
	{
		
		// Mouse movement.
		private var _prevPosition:Point = new Point();
		private var _downPosition:Point = new Point();
		private var _currPosition:Point = new Point();
		
		private var _mouseDown:Boolean = false;
		private var _rightMouseDown:Boolean = false;
		
		private var _overBlock:Mesh;
		
		public function MouseModel()
		{
			super();
		}
		
		public function setMouseDown( x:Number, y:Number ):void {
			_mouseDown = true;
			doMouseDown( x, y );
		}
		
		public function setRightMouseDown( x:Number, y:Number ):void {
			_rightMouseDown = true;
			doMouseDown( x, y );
		}
		
		private function doMouseDown( x:Number, y:Number ):void {
			_downPosition.x = x;
			_downPosition.y = y;
			_currPosition.x = x;
			_currPosition.y = y;
		}
		
		public function setMouseUp():void {
			_mouseDown = false;
			_rightMouseDown = false;
		}
		
		public function moveMouse( x:Number, y:Number ):void {
			_prevPosition.x = _currPosition.x;
			_prevPosition.y = _currPosition.y;
			_currPosition.x = x;
			_currPosition.y = y;
		}
		
		public function mouseOver( block:Mesh ):void {
			_overBlock = block;
		}
		
		public function mouseOut( block:Mesh ):void {
			if ( _overBlock == block ) {
				_overBlock = null;
			}
		}
		
		public function get isMoving():Boolean {
			if ( _currPosition && _prevPosition ) {
				return !_currPosition.equals( _prevPosition );
			}
			return false;
		}
		
		public function get mouseDown():Boolean {
			return _mouseDown;
		}
		
		public function get rightMouseDown():Boolean {
			return _rightMouseDown;
		}
		
		public function get canClick():Boolean {
			return ( _currPosition.subtract( _downPosition ).length < 10 );
		}
		
		public function get prevPosition():Point {
			return _prevPosition;
		}
		
		public function get overBlock():Mesh {
			return _overBlock;
		}
	}
}