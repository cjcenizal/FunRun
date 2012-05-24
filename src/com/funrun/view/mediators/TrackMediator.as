package com.funrun.view.mediators
{
	import com.funrun.controller.events.AddCameraFulfilled;
	import com.funrun.controller.events.AddObjectToSceneRequest;
	import com.funrun.controller.events.EnablePlayerInputRequest;
	import com.funrun.controller.events.RemoveObjectFromSceneRequest;
	import com.funrun.controller.events.RenderSceneRequest;
	import com.funrun.view.components.TrackView;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class TrackMediator extends Mediator implements IMediator
	{
		[Inject]
		public var view:TrackView;
		
		private var stage:Stage;
		
		override public function onRegister():void {
			stage = view.stage;
			view.init();
			view.debug();
			
			eventMap.mapListener( eventDispatcher, AddObjectToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED, onAddObjectToSceneRequested );
			eventMap.mapListener( eventDispatcher, RemoveObjectFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED, onRemoveObjectFromSceneRequested );
			eventMap.mapListener( eventDispatcher, RenderSceneRequest.RENDER_SCENE_REQUESTED, onRenderSceneRequested );
			eventMap.mapListener( eventDispatcher, EnablePlayerInputRequest.ENABLE_PLAYER_INPUT_REQUESTED, onEnablePlayerInputRequested );
			
			// Expose access to the camera.
			eventDispatcher.dispatchEvent( new AddCameraFulfilled( AddCameraFulfilled.ADD_CAMERA_FULFILLED, view.camera ) );
		}
		
		/**
		 * Turn on player keyboard input.
		 */
		private function onEnablePlayerInputRequested( e:EnablePlayerInputRequest ):void {
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		/**
		 * Add an object to the scene.
		 */
		private function onAddObjectToSceneRequested( e:AddObjectToSceneRequest ):void {
			view.addToScene( e.object );
		}
		
		/**
		 * Remove an object from the scene.
		 */
		private function onRemoveObjectFromSceneRequested( e:RemoveObjectFromSceneRequest ):void {
			view.removeFromScene( e.object );
		}
		
		/**
		 * Render the scene.
		 */
		private function onRenderSceneRequested( e:RenderSceneRequest ):void {
			view.render();
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
	}
}