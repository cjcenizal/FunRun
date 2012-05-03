package com.funrun.view.components {
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.render.RendererBase;
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
		
		// Constants.
		private const START_POS:Number = 500;
		private const GEO_SIZE:Number = 10 * 5;
		private const TRIGGER_POS:Number = START_POS - 100;
		private const END_POS:Number = -600;
		private const MESH_WIDTH:Number = 100;
		private var _speed:Number = 10;
		private var _obstacles:Array;
		
		private var _geosModel:GeosModel = new GeosModel();
		private var _obstaclesModel:ObstaclesModel = new ObstaclesModel();
		private var _factory:ObstacleFactory = new ObstacleFactory();
		//private var _course:ObstacleCourse;
		
		
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
		
		public var player:Mesh;
		
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
			start();
		}
		
		/**
		 * Initialise the engine
		 */
		private function initEngine():void {			
			view = new View3D();
		//	view.antiAlias = 16;
			view.forceMouseMove = true; // Force mouse move-related events even when the mouse hasn't moved.
			view.width = 800;
			view.height = 600;
			view.backgroundColor = 0x111111;
			addChild( view );
			
			scene = view.scene; // Store local refs.
			camera = view.camera;
			camera.y = 200;
			camera.z = -1000;
			camera.lens = new PerspectiveLens( 90 );
			camera.lens.far = 7000; // the higher the value, the blockier the shadows
			
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
		
		/**
		 * Navigation and render loop
		 */
		public function update():void {
			view.render();
			
			// Velocity += gravity
			// Velocity *= friction
			// Position += velocity
			
			_velocity += _gravity;
		//	_velocity *= _friction;
			player.y += _velocity;
			player.x += _lateralVelocity;
			if ( player.y <= 25 ) {
				player.y = 25;
				_velocity = 0;
			}
			camera.x = player.x;
			var followFactor:Number = ( 800 + player.y < camera.y ) ? .6 : .2;
			camera.y += ( ( 800 + player.y ) - camera.y ) * followFactor; // try easing to follow the player instead of being locked
		}
		
		//private var _friction:Number = 1;//.98;
		private var _jumpSpeed:Number = 20;
		private var _lateralSpeed:Number = 3;
		private var _gravity:Number = -5;
		
		private var _velocity:Number = 0;
		private var _lateralVelocity:Number = 0;
		private var _isJumping:Boolean = false;
		private var _isMovingLeft:Boolean = false;
		private var _isMovingRight:Boolean = false;
		private var _isDucking:Boolean = false;
		
		public function jump():void {
			if ( !_isJumping ) {
				_velocity += _jumpSpeed;
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
				_lateralVelocity -= _lateralSpeed;
			}
			_isMovingLeft = true;
		}
		
		public function startMovingRight():void {
			if ( _isMovingLeft ) {
				stopMovingLeft();
			}
			if ( !_isMovingRight ) {
				_lateralVelocity += _lateralSpeed;
			}
			_isMovingRight = true;
		}
		
		public function startDucking():void {
			_isDucking = true;
		}
		
		public function stopMovingLeft():void {
			if ( _isMovingLeft ) {
				_lateralVelocity += _lateralSpeed;
			}
			_isMovingLeft = false;
		}
		
		public function stopMovingRight():void {
			if ( _isMovingRight ) {
				_lateralVelocity -= _lateralSpeed;
			}
			_isMovingRight = false;
		}

		public function stopDucking():void {
			_isDucking = false;
		}
		/*
		private function moveLeft():void {
			player.x -= _speed;
		}
		
		private function moveRight():void {
			player.x += _speed;
		}*/
		
		
		
		private function start():void {
			stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			addObstacle();
		}
		
		private function onEnterFrame( e:Event ):void {
			update();
			var obstacle:Obstacle;
			var len:int = _obstacles.length;
			// Update oldest obstacles first, newest ones last.
			
			for ( var i:int = len - 1; i >= 0; i-- ) {
				obstacle = _obstacles[ i ];
				var collides:Boolean = obstacle.collide( player );
				if ( collides ) {
					stage.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				}
				obstacle.move( -_speed );
			}
			if ( len > 0 ) {
				if ( obstacle.prevZ >= TRIGGER_POS && obstacle.z < TRIGGER_POS ) {
					addObstacle();
				}
				var obstacle:Obstacle = _obstacles[ len - 1 ];
				if ( obstacle.z <= END_POS ) {
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
			for ( var col:int = 0; col < 3; col++ ) {
				for ( var row:int = 0; row < 5; row++ ) {
					mesh = getMesh( data.geos[ row ][ col ] );
					if ( mesh ) {
						mesh.position = ( flip ) ? new Vector3D( ( 2 - col ) * MESH_WIDTH - (MESH_WIDTH * 1), 25, ( 4 - row ) * 50 ) : new Vector3D( col * MESH_WIDTH - (MESH_WIDTH * 1), 25, ( 4 - row ) * 50 );
						scene.addChild( mesh );
						obstacle.addGeo( mesh );
					}
				}
			}
			scene.addChild( obstacle );
			obstacle.move( START_POS );
			_obstacles.unshift( obstacle );
		}
		
		private var EMPTY_GEO:PlaneGeometry = new PlaneGeometry( 1, 1 );
		private var LEDGE_GEO:CubeGeometry = new CubeGeometry( MESH_WIDTH, 200, 10 );
		private var WALL_GEO:CubeGeometry = new CubeGeometry( MESH_WIDTH, 100, 10 );
		private var BEAM_GEO:CubeGeometry = new CubeGeometry( MESH_WIDTH, 10, 10 );
		
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
		
		private function onKeyDown( e:KeyboardEvent ):void {
			switch ( e.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					jump();
					break;
				case Keyboard.LEFT:
					startMovingLeft();
					break;
				case Keyboard.RIGHT:
					startMovingRight();
					break;
				case Keyboard.DOWN:
					startDucking();
					break;
			}	
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			if ( !stage.hasEventListener( Event.ENTER_FRAME ) ) stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			switch ( e.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					stopJumping();
					break;
				case Keyboard.LEFT:
					stopMovingLeft();
					break;
				case Keyboard.RIGHT:
					stopMovingRight();
					break;
				case Keyboard.DOWN:
					stopDucking();
					break;
			}
			
		}
		
	}
	
}
