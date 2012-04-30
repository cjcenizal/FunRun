package com.funrun.view {
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
	import away3d.primitives.CylinderGeometry;
	import away3d.primitives.PlaneGeometry;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	
	/**
	 * http://www.adobe.com/devnet/flashplayer/articles/creating-games-away3d.html
	 * - Compile with -swf-version=13
	 * - Add wmode: 'direct' param to html template
	 */
	public class ObstacleCourse extends Sprite {
		
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
		public function ObstacleCourse() {
		}
		
		/**
		 * Global initialise function
		 */
		public function init():void {
			initEngine();
			initLights();
			initMaterials();
			initObjects();
			initListeners();
		}
		
		/**
		 * Initialise the engine
		 */
		private function initEngine():void {			
			view = new View3D();
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
			camera.lens.far = 10000;
			
			// Add stats.
			awayStats = new AwayStats( view );
			addChild( awayStats );
		}
		
		/**
		 * Initialise the lights
		 */
		private function initLights():void {
			sun = new DirectionalLight( 0, -1, 1 );
			sun.z = 2000;
			scene.addChild( sun );
			pointLight = new PointLight();
			pointLight.position = new Vector3D( 0, 500, -1000 );
			scene.addChild( pointLight );
			lightPicker = new StaticLightPicker( [ pointLight, sun ] );
		}
		
		/**
		 * Initialise the material
		 */
		private function initMaterials():void {
			inactiveMaterial = new ColorMaterial( 0xFF0000 );
			inactiveMaterial.lightPicker = lightPicker;
			activeMaterial = new ColorMaterial( 0x0000FF );
			activeMaterial.lightPicker = lightPicker;
			offMaterial = new ColorMaterial( 0x00ff00 );
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
		 * Initialise the listeners
		 */
		private function initListeners():void {
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		/**
		 * Navigation and render loop
		 */
		private function onEnterFrame( event:Event ):void {
			view.render();
			camera.y = 800;
			
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
			
		}
		
		//private var _friction:Number = 1;//.98;
		private var _jumpSpeed:Number = 80;
		private var _lateralSpeed:Number = 30;
		private var _gravity:Number = -10;
		
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
	}
	
}
