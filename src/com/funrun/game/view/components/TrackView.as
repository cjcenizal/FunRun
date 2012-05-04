package com.funrun.game.view.components {
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.lights.LightBase;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CylinderGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.WireframeGrid;
	
	import com.funrun.game.model.Constants;
	import com.funrun.game.view.Obstacle;
	
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	
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
		private var player:Mesh;
		
		// Player state (store in model?).
		private var _forwardVelocity:Number = Constants.MAX_PLAYER_FORWARD_VELOCITY; // This may vary over time as you get slowed.
		private var _jumpVelocity:Number = 0;
		private var _lateralVelocity:Number = 0;
		private var _isJumping:Boolean = false;
		private var _isMovingLeft:Boolean = false;
		private var _isMovingRight:Boolean = false;
		private var _isDucking:Boolean = false;
		
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
			updatePlayer();
			updateCamera();
			updateObstacles();
			_view.render();
		}
		
		private function updatePlayer():void {
			_jumpVelocity += Constants.PLAYER_JUMP_GRAVITY;
			player.y += _jumpVelocity;
			player.x += _lateralVelocity;
			if ( player.y <= 25 ) {
				player.y = 25;
				_jumpVelocity = 0;
			}
		}
		
		private function updateCamera():void {
			_camera.x = player.x;
			var followFactor:Number = ( Constants.CAM_Y + player.y < _camera.y ) ? .6 : .2;
			_camera.y += ( ( Constants.CAM_Y + player.y ) - _camera.y ) * followFactor; // try easing to follow the player instead of being locked
		}
		
		private function updateObstacles():void {
			var obstacle:Obstacle;
			var len:int = _obstacles.length;
			// Update oldest obstacles first, newest ones last.
			for ( var i:int = len - 1; i >= 0; i-- ) {
				obstacle = _obstacles[ i ];
				obstacle.move( -_forwardVelocity );
				var collides:Boolean = obstacle.collide( player );
				if ( collides ) {
					//stage.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				}
			}
			if ( len > 0 ) {
				if ( obstacle.prevZ >= Constants.ADD_OBSTACLE_DEPTH && obstacle.z < Constants.ADD_OBSTACLE_DEPTH ) {
					//addObstacle();
				}
				var obstacle:Obstacle = _obstacles[ len - 1 ];
				if ( obstacle.z <= Constants.REMOVE_OBSTACLE_DEPTH ) {
					// Remove item.
					obstacle.destroy();
					_obstacles.splice( len - 1, 1 );
				}
			}
			for ( var i:int = 0; i < _obstacles.length; i++ ) {
				obstacle = _obstacles[ i ];
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
			this.player = player;
			_scene.addChild( player );
		}
		
		/**
		 * Adding obstacles to the scene.
		 */
		public function addObstacle( obstacle:Obstacle ):void {
			// New obstacles go in front.
			
			
			/*
			var obstacle:Obstacle = new Obstacle( obstacleData.id );
			var mesh:Mesh;
			var flip:Boolean = Math.random() < .5;
			var colLen:int = ( obstacleData.geos[ 0 ] as Array ).length;
			var rowLen:int = obstacleData.geos.length;
			var xAdjustment:Number = ( ( colLen - 1 ) * Constants.BLOCK_SIZE ) * .5;
			for ( var col:int = 0; col < colLen; col++ ) {
			for ( var row:int = 0; row < rowLen; row++ ) {
			mesh = getMesh( obstacleData.geos[ row ][ col ] );
			if ( mesh ) {
			var meshX:Number = ( flip ) ? ( colLen - 1 - col ) : col;
			meshX *= Constants.BLOCK_SIZE;
			meshX -= xAdjustment;
			var meshY:Number = mesh.bounds.max.y * .5;
			var meshZ:Number = ( rowLen - 1 - row ) * Constants.BLOCK_SIZE;
			mesh.position = new Vector3D( meshX, meshY, meshZ );
			_scene.addChild( mesh );
			obstacle.addGeo( mesh );
			}
			}
			}
			_scene.addChild( obstacle );
			obstacle.move( Constants.OBSTACLE_START_DEPTH );
			_obstacles.unshift( obstacle );
			*/
		}
		
		//private function getMesh( geo:String ):Mesh {
		//return null; // stub, move the real thing into the command.
		//}
		/*
		
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
		
		
	}
}
