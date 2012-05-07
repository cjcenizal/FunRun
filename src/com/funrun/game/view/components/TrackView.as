package com.funrun.game.view.components {
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.WireframeGrid;
	
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.model.Constants;
	import com.funrun.game.view.events.CollisionEvent;
	
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
		
		// Obstacle management (perhaps store this in the model?).
		private var _obstacles:Array;
		
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
			_obstacles = [];
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
		public function update():void {
			updateObstacles();
			updateFloor();
			updatePlayer();
			updateCamera();
			_view.render();
		}
		
		private function updateCamera():void {
			_camera.x = _player.x;
			var followFactor:Number = ( Constants.CAM_Y + _player.y < _camera.y ) ? .6 : .2;
			_camera.y += ( ( Constants.CAM_Y + _player.y ) - _camera.y ) * followFactor; // try easing to follow the player instead of being locked
		}
		
		private function updateObstacles():void {
			var obstacle:Obstacle;
			var len:int = _obstacles.length;
			// Update oldest obstacles first, newest ones last.
			for ( var i:int = len - 1; i >= 0; i-- ) {
				obstacle = _obstacles[ i ];
				obstacle.move( -_forwardVelocity );
			}
			// Check last obstacle for removal and addition of new obstacle.
			if ( len > 0 ) {
				if ( obstacle.prevZ >= Constants.ADD_OBSTACLE_DEPTH && obstacle.z < Constants.ADD_OBSTACLE_DEPTH ) {
					dispatchEvent( new AddObstacleRequest( AddObstacleRequest.ADD_OBSTACLE_REQUESTED ) );
				}
				var obstacle:Obstacle = _obstacles[ len - 1 ];
				if ( obstacle.z <= Constants.REMOVE_OBSTACLE_DEPTH ) {
					// Remove item.
					obstacle.destroy();
					_obstacles.splice( len - 1, 1 );
				}
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
			var obstacle:Obstacle;
			var len:int = _obstacles.length;
			// Update oldest obstacles first, newest ones last.
			for ( var i:int = len - 1; i >= 0; i-- ) {
				obstacle = _obstacles[ i ];
				var collides:Boolean = obstacle.collide( _player );
				if ( collides ) {
					dispatchEvent( new CollisionEvent( CollisionEvent.COLLISION ) );
				}
			}
		}
		
		private var _floorPanels:Array = [];
		
		private function updateFloor():void {
			var material:ColorMaterial = new ColorMaterial( 0xffffff );
			var panel:Mesh;
			var count:int = 0;
			for ( var x:int = 0; x < Constants.TRACK_WIDTH; x += Constants.BLOCK_SIZE ) {
				if ( count < _floorPanels.length ) {
					// Use existing panel if possible.
					panel = _floorPanels[ count ];
					panel.visible = true;
				} else {
					// Add new one if none are available.
					panel = new Mesh( new PlaneGeometry( Constants.BLOCK_SIZE, Constants.TRACK_LENGTH ), material );
					_floorPanels.push( panel );
					_scene.addChild( panel );
				}
				// Adjust position and size.
				panel.position.x = x;
				panel.position.z = Constants.TRACK_LENGTH * .5;
				count++;
			}
			// Turn off remaining panels.
			for ( var i:int = count; i < _floorPanels.length; i++ ) {
				( _floorPanels[ count ] as Mesh ).visible = false;
			}
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
		 * Adding obstacles to the scene.
		 */
		public function addObstacle( obstacle:Obstacle ):void {
			// New obstacles go in front.
			_obstacles.unshift( obstacle );
			_scene.addChild( obstacle );
			obstacle.move( Constants.TRACK_LENGTH );
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
