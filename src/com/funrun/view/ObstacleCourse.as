package com.funrun.view {
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
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
		private var pointLight:PointLight;
		private var lightPicker:StaticLightPicker;
		
		// Materials.
		public var activeMaterial:ColorMaterial;
		public var offMaterial:ColorMaterial;
		public var inactiveMaterial:ColorMaterial;
		
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
			// Set up view, scene, camera.
			view = new View3D();
			view.forceMouseMove = true; // Force mouse move-related events even when the mouse hasn't moved.
			view.width = 800;
			view.height = 600;
			view.backgroundColor = 0x111111;
			addChild( view );
			
			scene = view.scene; // Store local refs.
			camera = view.camera;
			camera.pitch( 20 );
			camera.y = 400;
			camera.lens = new PerspectiveLens( 90 );
			
			// Add stats.
			awayStats = new AwayStats( view );
			addChild( awayStats );
		}
		
		/**
		 * Initialise the lights
		 */
		private function initLights():void {
			// Create a light for the camera.
			pointLight = new PointLight();
			scene.addChild( pointLight );
			lightPicker = new StaticLightPicker( [ pointLight ] );
		}
		
		/**
		 * Initialise the material
		 */
		private function initMaterials():void {
			inactiveMaterial = new ColorMaterial( 0xFF0000 );
			inactiveMaterial.lightPicker = lightPicker;
			activeMaterial = new ColorMaterial( 0x0000FF );
			activeMaterial.lightPicker = lightPicker;
			offMaterial = new ColorMaterial( 0xFFFFFF );
			offMaterial.lightPicker = lightPicker;
		}
		
		/**
		 * Initialise the scene objects
		 */
		private function initObjects():void {
			var ground:Mesh = new Mesh( new PlaneGeometry( 1000, 2500 ), inactiveMaterial );
			ground.position = new Vector3D( 0, 0, 100 );
			scene.addChild( ground );
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
			pointLight.position = camera.position;
			view.render();
		}
	}
	
}
