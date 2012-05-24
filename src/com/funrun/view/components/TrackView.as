package com.funrun.view.components {
	
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	
	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.DisplayObjectContainer;
	
	/**
	 * http://www.adobe.com/devnet/flashplayer/articles/creating-games-away3d.html
	 * - Compile with -swf-version=13
	 * - Add wmode: 'direct' param to html template
	 */
	public class TrackView extends AbstractComponent {
		
		// Engine vars.
		private var _view:View3D;
		private var _scene:Scene3D;
		private var _camera:Camera3D;
		
		/**
		 * Constructor
		 */
		public function TrackView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
		
		/**
		 * Initialize our view, scene, and camera.
		 */
		public function init():void {
			_view = new View3D();
			_view.antiAlias = 2; // 2, 4, or 16
			_view.width = stage.stageWidth;
			_view.height = stage.stageHeight;
			_view.backgroundColor = 0xffffff;
			addChild( _view );
			_scene = _view.scene; // Store local refs.
			_camera = _view.camera;
		}
		
		/**
		 * Add debugging UI.
		 */
		public function debug():void {
			// Add stats.
			var awayStats:AwayStats = new AwayStats( _view );
			addChild( awayStats );
		}
		
		/**
		 * Rendering.
		 */
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
		
		public function set camera( camera:Camera3D ):void {
			_view.camera = camera;
			_camera = camera;
		}
		
		public function get camera():Camera3D {
			return _camera;
		}
	}
}
