package com.funrun.view {
	
	import away3d.bounds.*;
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.controllers.*;
	import away3d.core.base.*;
	import away3d.core.raycast.*;
	import away3d.debug.*;
	import away3d.entities.*;
	import away3d.events.*;
	import away3d.lights.*;
	import away3d.materials.*;
	import away3d.materials.lightpickers.*;
	import away3d.primitives.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.ui.*;
	
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
		private var cameraController:HoverController;
		
		// Lights.
		private var pointLight:PointLight;
		private var lightPicker:StaticLightPicker;
		
		// Materials.
		public var activeMaterial:ColorMaterial;
		public var offMaterial:ColorMaterial;
		public var inactiveMaterial:ColorMaterial;
		
		// Scene objects.
		private var meshIntersectionTracer:Mesh;
		private var meshes:Vector.<Mesh>;
		private var mouseHitMethod:uint = MouseHitMethod.MESH_ANY_HIT;
		
		// Navigation.
		private var move:Boolean = false;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		private var tiltSpeed:Number = 2;
		private var panSpeed:Number = 2;
		private var distanceSpeed:Number = 2;
		private var tiltIncrement:Number = 0;
		private var panIncrement:Number = 0;
		private var distanceIncrement:Number = 0;
		
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
			scene = view.scene; // Store local refs.
			camera = view.camera;
			
			// Setup controller to be used on the camera.
			cameraController = new HoverController( camera, null, 180, 20, 320, 5 );
			
			view.addSourceURL( "cenizal.com" ); // Accessible through context menu.
			addChild( view );
			
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
			// Locator materials.
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
		private var cube:Mesh;
		private function initObjects():void {
			
			
			// intersection points
			meshIntersectionTracer = new Mesh( new SphereGeometry( 2 ), new ColorMaterial( 0x00FF00, 0.5 ) );
			meshIntersectionTracer.visible = false;
			meshIntersectionTracer.mouseEnabled = false;
			scene.addChild( meshIntersectionTracer );
			
			meshes = new Vector.<Mesh>();
			
			// cubes
			var i:uint;
			var mesh:Mesh;
			var len:uint = 201;
			var cubeGeometry:CubeGeometry = new CubeGeometry( 30 * Math.random() + 20, 30 * Math.random() + 20, 30 * Math.random() + 20, 10, 10, 10 );
			
			/*for ( i = 0; i < len; ++i ) {
				if ( i ) {
					mesh = new Mesh( cubeGeometry, inactiveMaterial );
					mesh.rotationX = 360 * Math.random();
					mesh.rotationY = 360 * Math.random();
					mesh.rotationZ = 360 * Math.random();
					mesh.bakeTransformations();
					mesh.position = new Vector3D( 1500 * Math.random() - 750, 0, 1500 * Math.random() - 750 );
					if ( Math.random() > 0.75 ) {
						mesh.bounds = new BoundingSphere();
					}
					mesh.rotationX = 360 * Math.random();
					mesh.rotationY = 360 * Math.random();
					mesh.rotationZ = 360 * Math.random();
				} else {
				}
				
				if ( i && Math.random() > 0.5 ) { //add listener and update hit method
				
				} else { //leave mesh 
					mesh.material = offMaterial;
				}
				
				mesh.mouseHitMethod = mouseHitMethod;
				mesh.mouseEnabled = true;
				mesh.showBounds = true;
				mesh.bounds.boundingRenderable.color = 0x333333;
				
				meshes.push( mesh );
				scene.addChild( mesh );
			}*/
			
			mesh = new Mesh( new PlaneGeometry( 1000, 1000 ), inactiveMaterial );
			scene.addChild( mesh );
			
			// Add our fat-ass cube.
			cube = new Mesh( new CubeGeometry( 20, 20, 20 ), activeMaterial );
			cube.position = new Vector3D( 0, 0, 0 );
			//mesh.position = mesh.position.add( new Vector3D( 0, 20000, 0 ) );
		//	scene.addChild( cube );
			
			
		}
		
		/**
		 * Initialise the listeners
		 */
		private function initListeners():void {
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.addEventListener( Event.RESIZE, onResize );
			onResize();
		}
		
		/**
		 * Navigation and render loop
		 */
		private function onEnterFrame( event:Event ):void {
			if ( move ) {
				cameraController.panAngle = 0.3 * ( stage.mouseX - lastMouseX ) + lastPanAngle;
				cameraController.tiltAngle = 0.3 * ( stage.mouseY - lastMouseY ) + lastTiltAngle;
			}
			
			cameraController.panAngle += panIncrement;
			cameraController.tiltAngle += tiltIncrement;
			cameraController.distance += distanceIncrement;
			
			pointLight.position = camera.position;
			
			view.render();
			
		}
		
		
		
		/**
		 * Mouse stage leave listener for navigation
		 */
		private function onStageMouseLeave( event:Event ):void {
			move = false;
			stage.removeEventListener( Event.MOUSE_LEAVE, onStageMouseLeave );
		}
		
		/**
		 * stage listener for resize events
		 */
		private function onResize( event:Event = null ):void {
			view.width = stage.stageWidth;
			view.height = stage.stageHeight;
			//	SignatureBitmap.y = stage.stageHeight - Signature.height;
			awayStats.x = stage.stageWidth - awayStats.width;
		}
	}
	
}
