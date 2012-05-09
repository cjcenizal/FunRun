package com.funrun.game.view.components {
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.base.Geometry;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PrimitiveBase;
	import away3d.primitives.WireframeGrid;
	import away3d.tools.commands.Merge;
	
	import com.funrun.game.controller.events.AddObstacleRequest;
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
		
		// Player geometry (will be stored in the model?).
		private var _player:Mesh;
		
		// Player state (store in model?).
		private var _forwardVelocity:Number = Constants.MAX_PLAYER_FORWARD_VELOCITY; // This may vary over time as you get slowed.
		private var _jumpVelocity:Number = 0;
		private var _lateralVelocity:Number = 0;
		private var _isJumping:Boolean = false;
		private var _isMovingLeft:Boolean = false;
		private var _isMovingRight:Boolean = false;
		private var _isDucking:Boolean = false;
		private var _isAirborne:Boolean = false;
		
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
			
			/*
			_track = new Mesh( new CubeGeometry( 0, 0, 0 ), new ColorMaterial( 0, 0 ) );
			_track.z = 4000;
			var merge:Merge = new Merge( true );
			var geo:CubeGeometry = new CubeGeometry( 20, 20, 20 );
			var mat:ColorMaterial = new ColorMaterial( 0x0000ff );
			var mesh:Mesh;
			for ( var i:int = 0; i < 10; i++ ) {
				mesh = new Mesh( geo, mat );
				mesh.z = 2000 + Math.random() * 1000;
				mesh.x = Math.random() * 1000 - 500;
				mesh.y = Math.random() * 1000 - 500;
				merge.apply( _track, mesh );
			}
			_scene.addChild( _track );
			_tracks.push( _track );*/
		}
		private var _tracks:Array = [];
		
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
		public function update():void {
			updateObstacles();
			updatePlayer();
			updateCamera();
			_view.render();
		}
		
		private function updateCamera():void {
			_camera.x = _player.x;
			var followFactor:Number = ( Constants.CAM_Y + _player.y < _camera.y ) ? .6 : .2;
			_camera.y += ( ( Constants.CAM_Y + _player.y ) - _camera.y ) * followFactor; // try easing to follow the player instead of being locked
		}
		
		var t:int = 0;
		private function updateObstacles():void {
			t ++;
			for ( var i:int = 0; i < _tracks.length; i++ ) {
				( _tracks[ i ] as Mesh ).z -= _forwardVelocity;
			}
			if ( t % 40 == 0 ) {
				if ( t > 400 ) {
					_scene.removeChild( _tracks[ 0 ] );
					( _tracks[ 0 ] as Mesh ).geometry.dispose();
					_tracks.splice( 0, 1 );
				}
				dispatchEvent( new AddObstacleRequest( AddObstacleRequest.ADD_OBSTACLE_REQUESTED ) );
			}
		}
		
		private function updatePlayer():void {
			_jumpVelocity += Constants.PLAYER_JUMP_GRAVITY;
			_player.y += _jumpVelocity;
			_player.x += _lateralVelocity;
			if ( _player.y <= 25 ) { // Temp hack for landing on ground, fix later
				_player.y = 25; // 25 is half the player FPO object's height
				_jumpVelocity = 0;
			}
			_isAirborne = ( Math.abs( _player.y - 25 ) > 1 );
		}
		
		/**
		 * Adding obstacles to the scene.
		 */
		private var _track:Mesh;
		public function addObstacle( obstacle:Obstacle ):void {
			var merge:Merge = new Merge();
			var base:Mesh = new Mesh( new CubeGeometry(), new ColorMaterial( 0x0000ff ) );
			/*mesh.z = 1000 - _track.z;
			merge.apply( _track, mesh );*/
			/*var geo:CubeGeometry = new CubeGeometry( 20, 20, 20 );
			var mat:ColorMaterial = new ColorMaterial( 0x0000ff );
			var mesh:Mesh;
			for ( var i:int = 0; i < 100; i++ ) {
				mesh = new Mesh( geo, mat );
				mesh.z = 2000 + Math.random() * 4000 - _track.z;
				mesh.x = Math.random() * 1000 - 500;
				mesh.y = Math.random() * 1000 - 500;
				merge.apply( base, mesh );
			}
			
			merge.apply( _track, base );*/
			var merge:Merge = new Merge( true );
			var geo:CubeGeometry = new CubeGeometry( 20, 20, 20 );
			var mat:ColorMaterial = new ColorMaterial( 0x0000ff );
			var base:Mesh = new Mesh( geo, mat );
			base.z = 4000;
			var mesh:Mesh;
			for ( var i:int = 0; i < 40; i++ ) {
				mesh = new Mesh( new CubeGeometry( 20, 20, 20 ), mat );
				mesh.z = Math.random() * 100;
				mesh.x = Math.random() * 1000 - 500;
				mesh.y = Math.random() * 1000 - 500;
				merge.apply( base, mesh );
			}
			_tracks.push( base );
			_scene.addChild( base );
		}
		
		/**
		 * Adding 3D objects to the scene.
		 */
		public function addObject( child:ObjectContainer3D ):void {
			_scene.addChild( child );
		}
		
		/**
		 * Adding player to the scene.
		 */
		public function addPlayer( player:Mesh ):void {
			_player = player;
			_scene.addChild( player );
		}
		
		/**
		 * Control the player.
		 */
		public function jump():void {
			if ( !_isJumping ) {
				_jumpVelocity += Constants.PLAYER_JUMP_SPEED;
			}
			_isJumping = true;
		}
		
		public function stopJumping():void {
			_isJumping = false;
		}
		
		public function startMovingLeft():void {
			if ( _isMovingRight ) {
				stopMovingRight();
			}
			if ( !_isMovingLeft ) {
				_lateralVelocity -= Constants.PLAYER_LATERAL_SPEED;
			}
			_isMovingLeft = true;
		}
		
		public function startMovingRight():void {
			if ( _isMovingLeft ) {
				stopMovingLeft();
			}
			if ( !_isMovingRight ) {
				_lateralVelocity += Constants.PLAYER_LATERAL_SPEED;
			}
			_isMovingRight = true;
		}
		
		public function startDucking():void {
			_isDucking = true;
		}
		
		public function stopMovingLeft():void {
			if ( _isMovingLeft ) {
				_lateralVelocity += Constants.PLAYER_LATERAL_SPEED;
			}
			_isMovingLeft = false;
		}
		
		public function stopMovingRight():void {
			if ( _isMovingRight ) {
				_lateralVelocity -= Constants.PLAYER_LATERAL_SPEED;
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
	}
}
