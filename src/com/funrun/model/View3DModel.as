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
	
	public class View3DModel extends Actor {
		
		private var _view:View3D;
		private var _scene:Scene3D;
		private var _camera:Camera3D;
		public var cameraController:HoverController;
		public var target:Mesh;
		public var ease:Vector3D;
		private var _dest:Vector3D;
		
		public function View3DModel() {
			super();
			_dest = new Vector3D();
			ease = new Vector3D();
		}
		
		public function setView( view:View3D ):void {
			_view = view;
			_scene = _view.scene;
			_camera = _view.camera;
		}
		
		public function update( immediate:Boolean = false ):void {
			if ( immediate ) {
				target.x = _dest.x;
				target.y = _dest.y;
				target.z = _dest.z;
			} else {
				target.x += ( _dest.x - target.x ) * ease.x;
				target.y += ( _dest.y - target.y ) * ease.y;
				target.z += ( _dest.z - target.z ) * ease.z;
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
		
		public function setCameraPosition( x:Number, y:Number, z:Number ):void {
			if ( !isNaN( x ) ) _dest.x = x;
			if ( !isNaN( y ) ) _dest.y = y;
			if ( !isNaN( z ) ) _dest.z = z;
		}
	}
}
