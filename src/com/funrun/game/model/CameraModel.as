package com.funrun.game.model {
	
	import away3d.cameras.Camera3D;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CameraModel extends Actor {
		
		private var _position:Vector3D;
		private var _offsetY:Number = 0;
		private var _camera:Camera3D;
		
		public function CameraModel() {
			super();
			_position = new Vector3D();
		}
		
		public function setCamera( cam:Camera3D ):void {
			_camera = cam;
		}
		
		public function update():void {
			if ( _camera ) {
				_camera.x = _position.x;
				_camera.y = _position.y + _offsetY;
				_camera.z = _position.z;
			}
		}
		
		public function get x():Number {
			return _position.x;
		}
		
		public function set x( val:Number ):void {
			_position.x = val;
		}
		
		public function get y():Number {
			return _position.y;
		}
		
		public function set y( val:Number ):void {
			_position.y = val;
		}
		
		public function set z( val:Number ):void {
			_position.z = val;
		}
		
		public function set offsetY( val:Number ):void {
			_offsetY = val;
		}
	}
}
