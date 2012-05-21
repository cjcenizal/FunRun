package com.funrun.game.view.components {
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	
	import com.funrun.game.model.constants.TrackConstants;
	
	import flash.display.Sprite;
	
	/**
	 * http://www.adobe.com/devnet/flashplayer/articles/creating-games-away3d.html
	 * - Compile with -swf-version=13
	 * - Add wmode: 'direct' param to html template
	 */
	public class TrackView extends Sprite {
		
		// Engine vars.
		private var _view:View3D;
		private var _scene:Scene3D;
		private var _camera:Camera3D;
		
		/**
		 * Constructor
		 */
		public function TrackView() {
		}
		
		/**
		 * Initialize our view, scene, and camera.
		 */
		public function init():void {
			_view = new View3D();
			_view.antiAlias = 2; // 2, 4, or 16
			_view.width = 800;
			_view.height = 600;
			_view.backgroundColor = 0xffffff;
			addChild( _view );
			
			_scene = _view.scene; // Store local refs.
			_camera = _view.camera;
			_camera.y = TrackConstants.CAM_Y;
			_camera.z = TrackConstants.CAM_Z;
			_camera.rotationX = TrackConstants.CAM_TILT;
			_camera.lens = new PerspectiveLens( TrackConstants.CAM_FOV );
			_camera.lens.far = TrackConstants.CAM_FRUSTUM_DISTANCE;
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
		
		public function get camera():Camera3D {
			return _camera;
		}
	}
}
