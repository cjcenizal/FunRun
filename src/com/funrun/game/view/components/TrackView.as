package com.funrun.game.view.components {
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FilteredShadowMapMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.CylinderGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.WireframeGrid;
	
	import com.funrun.game.model.Constants;
	import com.funrun.game.model.GeosModel;
	import com.funrun.game.model.ObstacleVO;
	import com.funrun.game.model.ObstaclesModel;
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
		
		// Lights.
		private var _sunLight:DirectionalLight;
		private var _lightPicker:StaticLightPicker;
		
		// Obstacle management (perhaps store this in the model?).
		private var _obstacles:Array;
		
		// Player geometry (will be stored in the model?).
		private var player:Mesh;
		
		// Model references (inject these).
		private var _geosModel:GeosModel = new GeosModel();
		private var _obstaclesModel:ObstaclesModel = new ObstaclesModel();
		
		// Materials (put these into a model? or maybe they will be imported w/ the Blender model?).
		public var playerMaterial:ColorMaterial;
		public var groundMaterial:ColorMaterial;
		public var obstacleMaterial:ColorMaterial;
		
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
		}
		
		/**
		 * Global initialise function
		 */
		public function init():void {
			_obstacles = [];
			initEngine();
			initLights();
			initMaterials();
			initObjects();
		}
		
		/**
		 * Initialise the engine
		 */
		private function initEngine():void {
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
		 * Initialise the lights
		 */
		var mainLight:PointLight;
		
		private function initLights():void {
			_sunLight = new DirectionalLight( .5, -1, 0 );
			_sunLight.ambient = .1;
			_sunLight.z = 2000;
			_scene.addChild( _sunLight );
			mainLight = new PointLight();
			mainLight.castsShadows = true;
			mainLight.shadowMapper.depthMapSize = 1024;
			mainLight.y = 120;
			mainLight.color = 0xffffff;
			mainLight.diffuse = 1;
			mainLight.specular = 1;
			mainLight.radius = 400;
			mainLight.fallOff = 1000;
			mainLight.ambient = 0xa0a0c0;
			mainLight.ambient = .5;
			_scene.addChild( mainLight );
			_lightPicker = new StaticLightPicker( [ mainLight, _sunLight ] );
		}
		
		/**
		 * Initialise the material
		 */
		private function initMaterials():void {
			var shadowMethod:FilteredShadowMapMethod = new FilteredShadowMapMethod( _sunLight );
			var specularMethod:FresnelSpecularMethod = new FresnelSpecularMethod();
			
			playerMaterial = new ColorMaterial( 0x00FF00 );
			playerMaterial.lightPicker = _lightPicker;
			playerMaterial.shadowMethod = shadowMethod;
			playerMaterial.specular = .25;
			playerMaterial.gloss = 20;
			playerMaterial.specularMethod = specularMethod;
			
			groundMaterial = new ColorMaterial( 0xFF0000 );
			groundMaterial.lightPicker = _lightPicker;
			groundMaterial.shadowMethod = shadowMethod;
			groundMaterial.specular = .25;
			groundMaterial.gloss = 20;
			groundMaterial.specularMethod = specularMethod;
			
			obstacleMaterial = new ColorMaterial( 0x0000FF );
			obstacleMaterial.lightPicker = _lightPicker;
			obstacleMaterial.shadowMethod = shadowMethod;
			obstacleMaterial.specular = .25;
			obstacleMaterial.gloss = 20;
			obstacleMaterial.specularMethod = specularMethod;
		}
		
		/**
		 * Initialise the scene objects
		 */
		private function initObjects():void {
			var ground:Mesh = new Mesh( new PlaneGeometry( Constants.TRACK_WIDTH, Constants.TRACK_LENGTH ), groundMaterial );
			ground.position = new Vector3D( 0, 0, Constants.TRACK_LENGTH * .5 - 300 );
			_scene.addChild( ground );
			player = new Mesh( new CylinderGeometry( 50, 50, 50 ), playerMaterial );
			player.position = new Vector3D( 0, 25, 0 );
			_scene.addChild( player );
		}
		
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
		
		public function start():void {
			addObstacle();
		}
		
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
					addObstacle();
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
		
		private function addObstacle():void {
			// New obstacles go in front.
			var data:ObstacleVO = _obstaclesModel.getRandomObstacle();
			var obstacle:Obstacle = new Obstacle( data.id );
			var mesh:Mesh;
			var flip:Boolean = Math.random() < .5;
			var colLen:int = ( data.geos[ 0 ] as Array ).length;
			var rowLen:int = data.geos.length;
			var xAdjustment:Number = ( ( colLen - 1 ) * Constants.BLOCK_SIZE ) * .5;
			for ( var col:int = 0; col < colLen; col++ ) {
				for ( var row:int = 0; row < rowLen; row++ ) {
					mesh = getMesh( data.geos[ row ][ col ] );
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
		}
		
		private function getMesh( geo:String ):Mesh {
			var mesh:Mesh;
			switch ( geo ) {
				case "empty":  {
					mesh = null;
					break;
				}
				case "ledge":  {
					mesh = new Mesh( _geosModel.getGeo( _geosModel.LEDGE_GEO ), obstacleMaterial );
					break;
				}
				case "wall":  {
					mesh = new Mesh( _geosModel.getGeo( _geosModel.WALL_GEO ), obstacleMaterial );
					break;
				}
				case "beam":  {
					mesh = new Mesh( _geosModel.getGeo( _geosModel.BEAM_GEO ), obstacleMaterial );
					break;
				}
			}
			return mesh;
		}
	}
}
