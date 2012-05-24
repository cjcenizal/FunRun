package com.funrun.view.mediators
{
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	
	import com.funrun.controller.signals.AddCameraRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.view.components.TrackView;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class TrackMediator extends Mediator implements IMediator
	{
		[Inject]
		public var view:TrackView;
		
		[Inject]
		public var addCameraRequest:AddCameraRequest;
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var enablePlayerInputRequest:EnablePlayerInputRequest;
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		private var stage:Stage;
		
		override public function onRegister():void {
			stage = view.stage;
			view.init();
			view.debug();
			
			addCameraRequest.add( onAddCameraRequested );
			addObjectToSceneRequest.add( onAddObjectToSceneRequested );
			removeObjectFromSceneRequest.add( onRemoveObjectFromSceneRequested );
			renderSceneRequest.add( onRenderSceneRequested );
			enablePlayerInputRequest.add( onEnablePlayerInputRequested );
		}
		
		/**
		 * Turn on/off player keyboard input.
		 */
		private function onEnablePlayerInputRequested( enabled:Boolean ):void {
			if ( enabled ) {
				stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
				stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			} else {
				stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
				stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			}
		}
		/**
		 * Add an object to the scene.
		 */
		private function onAddObjectToSceneRequested( object:ObjectContainer3D ):void {
			view.addToScene( object );
		}
		
		/**
		 * Remove an object from the scene.
		 */
		private function onRemoveObjectFromSceneRequested( object:ObjectContainer3D ):void {
			view.removeFromScene( object );
		}
		
		/**
		 * Render the scene.
		 */
		private function onRenderSceneRequested():void {
			view.render();
		}
		
		/**
		 * Swap out track's camera.
		 */
		private function onAddCameraRequested( camera:Camera3D ):void {
			view.camera = camera;
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
	}
}