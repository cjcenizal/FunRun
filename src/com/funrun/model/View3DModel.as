package com.funrun.model {
	
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class View3DModel extends Actor {
		
		private var _view:View3D;
		private var _scene:Scene3D;
		private var _camera:Camera3D;
		private var _cameraPosition:Vector3D;
		private var _cameraRotation:Vector3D;
		private var _cameraOffsetY:Number = 0;
		
		public function View3DModel() {
			super();
			_cameraPosition = new Vector3D();
			_cameraRotation = new Vector3D();
		}
		
		public function setView( view:View3D ):void {
			_view = view;
			_scene = _view.scene;
			_camera = _view.camera;
		}
		
		public function update():void {
			if ( _camera ) {
				_camera.x = _cameraPosition.x;
				_camera.y = _cameraPosition.y + _cameraOffsetY;
				_camera.z = _cameraPosition.z;
				
				_camera.rotationX= _cameraRotation.x;
				_camera.rotationY = _cameraRotation.y;
				_camera.rotationZ = _cameraRotation.z;
			}
		}
		
		public function render():void {
			_view.render();
		}
		
		/**
		 * Adding 3D objects to the scene.
		 */
		public function addToScene( object:ObjectContainer3D ):void {
			_scene.addChild( object );
		}
		
		/**
		 * Removing 3D objects from the scene.
		 */
		public function removeFromScene( object:ObjectContainer3D ):void {
			_scene.removeChild( object );
		}
		
		public function get2DFrom3D( position:Vector3D ):Point {
			return _view.project( position );
		}
		
		public function lookAt( target:Vector3D ):void {
			_camera.lookAt( target );
		}
		
		public function get cameraX():Number {
			return _cameraPosition.x;
		}
		
		public function set cameraX( val:Number ):void {
			_cameraPosition.x = val;
		}
		
		public function get cameraY():Number {
			return _cameraPosition.y;
		}
		
		public function set cameraY( val:Number ):void {
			_cameraPosition.y = val;
		}
		
		public function get cameraZ():Number {
			return _cameraPosition.z;
		}
		
		public function set cameraZ( val:Number ):void {
			_cameraPosition.z = val;
		}
		
		public function set cameraOffsetY( val:Number ):void {
			_cameraOffsetY = val;
		}
		
		public function get cameraRotationX():Number {
			return _cameraRotation.x;
		}
		
		public function set cameraRotationX( val:Number ):void {
			_cameraRotation.x = val;
		}
		
		public function get cameraRotationY():Number {
			return _cameraRotation.y;
		}
		
		public function set cameraRotationY( val:Number ):void {
			_cameraRotation.y = val;
		}
		
		public function get cameraRotationZ():Number {
			return _cameraRotation.z;
		}
		
		public function set cameraRotationZ( val:Number ):void {
			_cameraRotation.z = val;
		}
	}
}
