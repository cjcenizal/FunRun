package com.funrun.game.view.components {
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.primitives.WireframeGrid;
	
	import com.funrun.game.model.Constants;
	
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
		 * Global initialise function
		 */
		public function init():void {
			_view = new View3D();
			_view.antiAlias = 2; // 2, 4, or 16
			_view.width = 800;
			_view.height = 600;
			_view.backgroundColor = 0x111111;
			addChild( _view );
			
			_scene = _view.scene; // Store local refs.
			_camera = _view.camera;
			_camera.y = Constants.CAM_Y;
			_camera.z = Constants.CAM_Z;
			_camera.rotationX = Constants.CAM_TILT;
			_camera.lens = new PerspectiveLens( Constants.CAM_FOV );
			_camera.lens.far = Constants.CAM_FRUSTUM_DISTANCE;
		}
		
		/**
		 * Add debugging UI.
		 */
		public function debug():void {
			// Add stats.
			var awayStats:AwayStats = new AwayStats( _view );
			addChild( awayStats );
			// Add grid.
			var grid:WireframeGrid = new WireframeGrid( Constants.TRACK_WIDTH / Constants.BLOCK_SIZE, Constants.TRACK_WIDTH, 2, 0xFFFFFF, WireframeGrid.PLANE_XZ );
			var gridScale:Number = 4;
			grid.scaleZ = gridScale;
			grid.z = Constants.TRACK_WIDTH * gridScale * .5 - 300;
			_scene.addChild( grid );
			grid.y = 1;
		}
		
		/**
		 * Updating.
		 */
		public function render():void {
			_view.render();
		}
		
		private function updateCamera():void {
		//	_camera.x = _player.x;
		//	var followFactor:Number = ( Constants.CAM_Y + _player.y < _camera.y ) ? .6 : .2;
		//	_camera.y += ( ( Constants.CAM_Y + _player.y ) - _camera.y ) * followFactor; // try easing to follow the player instead of being locked
		}
		
		/**
		 * Adding 3D objects to the scene.
		 */
		public function addToScene( object:ObjectContainer3D ):void {
			_scene.addChild( object );
		}
		
		/**
		 * Removing 3D objects to the scene.
		 */
		public function removeFromScene( object:ObjectContainer3D ):void {
			_scene.removeChild( object );
		}
	}
}
