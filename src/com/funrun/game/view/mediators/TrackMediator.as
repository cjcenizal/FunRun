package com.funrun.game.view.mediators
{
	import com.funrun.game.controller.events.AddCameraFulfilled;
	import com.funrun.game.controller.events.AddObjectToSceneRequest;
	import com.funrun.game.controller.events.AddTrackViewFulfilled;
	import com.funrun.game.controller.events.EnablePlayerInputRequest;
	import com.funrun.game.controller.events.RemoveObjectFromSceneRequest;
	import com.funrun.game.controller.events.RenderSceneRequest;
	import com.funrun.game.view.components.TrackView;
	import com.funrun.game.view.events.CollisionEvent;
	
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
			// Let everyone know we're present and accounted for.
			eventDispatcher.dispatchEvent( new AddTrackViewFulfilled( AddTrackViewFulfilled.ADD_TRACK_FULFILLED ) );
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