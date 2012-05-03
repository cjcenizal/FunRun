package com.funrun.view.components {
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
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.CylinderGeometry;
	import away3d.primitives.PlaneGeometry;
	
	import com.funrun.model.GeosModel;
	import com.funrun.model.ObstacleVO;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.view.Obstacle;
	import com.funrun.view.ObstacleFactory;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	
	
	/**
	 * http://www.adobe.com/devnet/flashplayer/articles/creating-games-away3d.html
	 * - Compile with -swf-version=13
	 * - Add wmode: 'direct' param to html template
	 */
	public class Track extends Sprite {
		
		// Block size.
		private const BLOCK_WIDTH:Number = 100;
		
		// Track speed (can vary over time).
		private const MAX_TRACK_SPEED:Number = BLOCK_WIDTH * .7;
		private var _trackSpeed:Number = MAX_TRACK_SPEED;
		
		// Camera.
		private const CAM_DEPTH:Number = -1000;
		private const CAM_HEIGHT:Number = 400;
		private const CAM_FOV:Number = 60;
		private const CAM_FRUSTUM_DISTANCE:Number = 6000; // the higher the value, the blockier the shadows
		
		// Player movement constants.
		private const PLAYER_JUMP_SPEED:Number = 60;
		private const PLAYER_LATERAL_SPEED:Number = BLOCK_WIDTH * .2;
		private const PLAYER_JUMP_GRAVITY:Number = -10;
		
		// Constants.
		private const START_POS:Number = 50 * BLOCK_WIDTH;
		private const OBSTACLE_INTERVAL:Number = 15 * BLOCK_WIDTH;
		private const ADD_OBSTACLE_POSITION:Number = START_POS - OBSTACLE_INTERVAL;
		private const REMOVE_OBSTACLE_POSITION:Number = -10 * BLOCK_WIDTH;
		private var _obstacles:Array;
		
		// Data.
		private var _geosModel:GeosModel = new GeosModel();
		private var _obstaclesModel:ObstaclesModel = new ObstaclesModel();
		private var _factory:ObstacleFactory = new ObstacleFactory();
		
		// Engine vars.
		public var scene:Scene3D;
		private var camera:Camera3D;
		private var view:View3D;
		private var awayStats:AwayStats;
		
		// Lights.
		private var sun:DirectionalLight;
		private var pointLight:PointLight;
		private var lightPicker:StaticLightPicker;
		
		// Materials.
		public var activeMaterial:ColorMaterial;
		public var offMaterial:ColorMaterial;
		public var inactiveMaterial:ColorMaterial;
		
		// Player geometry.
		public var player:Mesh;
		
		// Player state.
		private var _velocity:Number = 0;
		private var _lateralVelocity:Number = 0;
		private var _isJumping:Boolean = false;
		private var _isMovingLeft:Boolean = false;
		private var _isMovingRight:Boolean = false;
		private var _isDucking:Boolean = false;
		
		// Obstacle geometry.
		private var EMPTY_GEO:PlaneGeometry = new PlaneGeometry( 1, 1 );
		private var LEDGE_GEO:CubeGeometry = new CubeGeometry( 1 * BLOCK_WIDTH, 5 * BLOCK_WIDTH, 1 * BLOCK_WIDTH );
		private var WALL_GEO:CubeGeometry = new CubeGeometry( 1 * BLOCK_WIDTH, 2 * BLOCK_WIDTH, 1 * BLOCK_WIDTH );
		private var BEAM_GEO:CubeGeometry = new CubeGeometry( 1 * BLOCK_WIDTH, 1 * BLOCK_WIDTH, 1 * BLOCK_WIDTH );
		
		
		/**
		 * Constructor
		 */
		public function Track() {
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
			view = new View3D();
		//	view.antiAlias = 16; // 2, 4, or 16
			view.forceMouseMove = true; // Force mouse move-related events even when the mouse hasn't moved.
			view.width = 800;
			view.height = 600;
			view.backgroundColor = 0x111111;
			addChild( view );
			
			scene = view.scene; // Store local refs.
			camera = view.camera;
			camera.y = CAM_HEIGHT;
			camera.z = CAM_DEPTH;
			camera.lens = new PerspectiveLens( CAM_FOV );
			camera.lens.far = CAM_FRUSTUM_DISTANCE;
		}
		
		public function addStats():void {
			// Add stats.
			awayStats = new AwayStats( view );
			addChild( awayStats );
		}
		
		/**
		 * Initialise the lights
		 */
		private function initLights():void {
			sun = new DirectionalLight( .5, -1, 0 );
			sun.z = 2000;
			scene.addChild( sun );
			pointLight = new PointLight();
			pointLight.position = new Vector3D( 0, 500, -1000 );
			pointLight.castsShadows = true;
			scene.addChild( pointLight );
			lightPicker = new StaticLightPicker( [ pointLight, sun ] );
		}
		
		/**
		 * Initialise the material
		 */
		private function initMaterials():void {
			var shadowMethod:FilteredShadowMapMethod = new FilteredShadowMapMethod( sun );
			inactiveMaterial = new ColorMaterial( 0xFF0000 );
			inactiveMaterial.shadowMethod = shadowMethod; 
			inactiveMaterial.lightPicker = lightPicker;
			activeMaterial = new ColorMaterial( 0x0000FF );
			activeMaterial.shadowMethod = shadowMethod; 
			activeMaterial.lightPicker = lightPicker;
			offMaterial = new ColorMaterial( 0x00ff00 );
			offMaterial.shadowMethod = shadowMethod; 
			offMaterial.lightPicker = lightPicker;
		}
		
		/**
		 * Initialise the scene objects
		 */
		private function initObjects():void {
			var w:int = 1200;
			var h:int = 10000;
			var ground:Mesh = new Mesh( new PlaneGeometry( w, h ), inactiveMaterial );
			ground.position = new Vector3D( 0, 0, 700 );
			scene.addChild( ground );
			player = new Mesh( new CylinderGeometry( 50, 50, 50 ), offMaterial );
			player.position = new Vector3D( 0, 25, 0 );
			scene.addChild( player );
		}
		
		
		
		
		public function jump():void {
			if ( !_isJumping ) {
				_velocity += PLAYER_JUMP_SPEED;
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
				_lateralVelocity -= PLAYER_LATERAL_SPEED;
			}
			_isMovingLeft = true;
		}
		
		public function startMovingRight():void {
			if ( _isMovingLeft ) {
				stopMovingLeft();
			}
			if ( !_isMovingRight ) {
				_lateralVelocity += PLAYER_LATERAL_SPEED;
			}
			_isMovingRight = true;
		}
		
		public function startDucking():void {
			_isDucking = true;
		}
		
		public function stopMovingLeft():void {
			if ( _isMovingLeft ) {
				_lateralVelocity += PLAYER_LATERAL_SPEED;
			}
			_isMovingLeft = false;
		}
		
		public function stopMovingRight():void {
			if ( _isMovingRight ) {
				_lateralVelocity -= PLAYER_LATERAL_SPEED;
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
			view.render();
		}
		
		private function updatePlayer():void {
			_velocity += PLAYER_JUMP_GRAVITY;
			//	_velocity *= _friction;
			player.y += _velocity;
			player.x += _lateralVelocity;
			if ( player.y <= 25 ) {
				player.y = 25;
				_velocity = 0;
			}
		}
		
		private function updateCamera():void {
			camera.x = player.x;
			var followFactor:Number = ( CAM_HEIGHT + player.y < camera.y ) ? .6 : .2;
			camera.y += ( ( CAM_HEIGHT + player.y ) - camera.y ) * followFactor; // try easing to follow the player instead of being locked
		}
		
		private function updateObstacles():void {
			var obstacle:Obstacle;
			var len:int = _obstacles.length;
			// Update oldest obstacles first, newest ones last.
			
			for ( var i:int = len - 1; i >= 0; i-- ) {
				obstacle = _obstacles[ i ];
				obstacle.move( -_trackSpeed );
				var collides:Boolean = obstacle.collide( player );
				if ( collides ) {
					//stage.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				}
			}
			if ( len > 0 ) {
				if ( obstacle.prevZ >= ADD_OBSTACLE_POSITION && obstacle.z < ADD_OBSTACLE_POSITION ) {
					addObstacle();
				}
				var obstacle:Obstacle = _obstacles[ len - 1 ];
				if ( obstacle.z <= REMOVE_OBSTACLE_POSITION ) {
					// Remove item.
					obstacle.destroy();
					_obstacles.splice( len - 1, 1 );
				}
			}
			for ( var i:int = 0; i < _obstacles.length; i++ ) {
				obstacle = _obstacles[ i ];
			}
		}
		
		// WE NEED TO FIX THIS SO THAT OBSTACLES ARE CENTERED AROUND THE Z AXIS.
		private function addObstacle():void {
			// New obstacles go in front.
			var data:ObstacleVO = _obstaclesModel.getRandomObstacle();
			var obstacle:Obstacle = new Obstacle( data.id );
			var mesh:Mesh;
			var flip:Boolean = Math.random() < .5;
			var colLen:int = ( data.geos[ 0 ] as Array ).length;
			var rowLen:int =  data.geos.length;
			for ( var col:int = 0; col < colLen; col++ ) {
				for ( var row:int = 0; row < rowLen; row++ ) {
					mesh = getMesh( data.geos[ row ][ col ] );
					if ( mesh ) {
						var meshX:Number = ( flip )
							? ( colLen - 1 - col ) * BLOCK_WIDTH - ( BLOCK_WIDTH * 1 )
							: col * BLOCK_WIDTH - ( BLOCK_WIDTH * 1);
						var meshY:Number = mesh.bounds.max.y * .5;
						var meshZ:Number = ( rowLen - 1 - row ) * BLOCK_WIDTH;
						mesh.position = new Vector3D( meshX, meshY, meshZ );
						scene.addChild( mesh );
						obstacle.addGeo( mesh );
					}
				}
			}
			scene.addChild( obstacle );
			obstacle.move( START_POS );
			_obstacles.unshift( obstacle );
		}
		
		private function getMesh( geo:String ):Mesh {
			var mesh:Mesh;
			switch ( geo ) {
				case "empty":
					mesh = null;//new Mesh( EMPTY_GEO, activeMaterial );
					break;
				
				case "ledge":
					mesh = new Mesh( LEDGE_GEO, activeMaterial );
					break;
				
				case "wall":
					mesh = new Mesh( WALL_GEO, activeMaterial );
					break;
				
				case "beam":
					mesh = new Mesh( BEAM_GEO, activeMaterial );
					break;
			}
			return mesh;
		}
		
	}
	
}
