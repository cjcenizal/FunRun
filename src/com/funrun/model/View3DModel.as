package com.funrun.model {
	
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class View3dModel extends Actor {
		
		private var _view:View3D;
		private var _scene:Scene3D;
		private var _camera:Camera3D;
		private var _cameraController:HoverController;
		private var _targetTilt:Number = 0;
		private var _targetPan:Number = 0;
		private var _targetDistance:Number = 0;
		private var _isInterpolating:Boolean = false;
		public var easeHover:Number = 1;
		public var target:Mesh;
		public var ease:Vector3D;
		private var _dest:Vector3D;
		
		// Camera control.
		public var lastPanAngle:Number;
		public var lastTiltAngle:Number;
		public var lastMouseX:Number;
		public var lastMouseY:Number;
		
		public function View3dModel() {
			super();
			_dest = new Vector3D();
			ease = new Vector3D();
		}
		
		public function setView( view:View3D ):void {
			_view = view;
			_scene = _view.scene;
			_camera = _view.camera;
		}
		
		public function setCameraController( cameraController:HoverController ):void {
			_cameraController = cameraController;
		}
		
		public function update( immediate:Boolean = false ):void {
			if ( immediate ) {
				target.x = _dest.x;
				target.y = _dest.y;
				target.z = _dest.z;
				_cameraController.panAngle = _targetTilt;
				_cameraController.tiltAngle = _targetTilt;
				_cameraController.distance = _targetDistance;
			} else {
				target.x += ( _dest.x - target.x ) * ease.x;
				target.y += ( _dest.y - target.y ) * ease.y;
				target.z += ( _dest.z - target.z ) * ease.z;
				if ( _isInterpolating ) {
					_cameraController.panAngle += ( _targetPan - _cameraController.panAngle ) * easeHover;
					_cameraController.tiltAngle += ( _targetTilt - _cameraController.tiltAngle ) * easeHover;
					_cameraController.distance += ( _targetDistance - _cameraController.distance ) * easeHover;
				}
			}
		}
		
		public function render():void {
			_view.render();
		}
		
		/**
		 * Adding 3D objects to the scene.
		 */
		public function addToScene( object:ObjectContainer3D ):void {
			if ( !_scene.contains( object ) ) {
				_scene.addChild( object );
			}
		}
		
		/**
		 * Removing 3D objects from the scene.
		 */
		public function removeFromScene( object:ObjectContainer3D ):void {
			if ( _scene.contains( object ) ) {
				_scene.removeChild( object );
			}
		}
		
		public function project( position:Vector3D ):Point {
			var pos:Vector3D = _view.project( position );
			return new Point( pos.x, pos.y );
		}
		
		public function setTargetPosition( x:Number, y:Number, z:Number ):void {
			if ( !isNaN( x ) ) _dest.x = x;
			if ( !isNaN( y ) ) _dest.y = y;
			if ( !isNaN( z ) ) _dest.z = z;
		}
		
		public function setTargetPerspective( pan:Number, tilt:Number, distance:Number ):void {
			_isInterpolating = true;
			_targetPan = pan;
			_targetTilt = tilt;
			_targetDistance = distance;
		}
		
		public function setPerspective( pan:Number, tilt:Number, distance:Number ):void {
			_isInterpolating = false;
			_cameraController.panAngle = pan;
			_cameraController.tiltAngle = tilt;
			_cameraController.distance = distance;
		}
		
		public function get targetDistance():Number {
			return _targetDistance;
		}
		
		public function get targetPan():Number {
			return _targetPan;
		}
		
		public function get targetTilt():Number {
			return _targetTilt;
		}
		
		public function get panAngle():Number {
			return _cameraController.panAngle;
		}
		
		public function get tiltAngle():Number {
			return _cameraController.tiltAngle;
		}
		
		public function get distance():Number {
			return _cameraController.distance;
		}
	}
}
