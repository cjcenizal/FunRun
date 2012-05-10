package com.funrun.game.view.mediators
{
	import com.funrun.game.controller.events.AddCameraFulfilled;
	import com.funrun.game.controller.events.AddObjectToSceneRequest;
	import com.funrun.game.controller.events.AddTrackFulfilled;
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
			view.addEventListener( CollisionEvent.COLLISION, onCollision );
			
			eventMap.mapListener( eventDispatcher, AddObjectToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED, onAddObjectToSceneRequested );
			eventMap.mapListener( eventDispatcher, RemoveObjectFromSceneRequest.REMOVE_OBSTACLE_FROM_SCENE_REQUESTED, onRemoveObjectFromSceneRequested );
			eventMap.mapListener( eventDispatcher, RenderSceneRequest.RENDER_SCENE_REQUESTED, onRenderSceneRequested );
			eventMap.mapListener( eventDispatcher, EnablePlayerInputRequest.ENABLE_PLAYER_INPUT_REQUESTED, onEnablePlayerInputRequested );
			
			// Expose access to the camera.
			eventDispatcher.dispatchEvent( new AddCameraFulfilled( AddCameraFulfilled.ADD_CAMERA_FULFILLED, view.camera ) );
			// Let everyone know we're present and accounted for.
			eventDispatcher.dispatchEvent( new AddTrackFulfilled( AddTrackFulfilled.ADD_TRACK_FULFILLED ) );
		}
		
		private function onEnablePlayerInputRequested( e:EnablePlayerInputRequest ):void {
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		
		private function onAddObjectToSceneRequested( e:AddObjectToSceneRequest ):void {
			view.addToScene( e.object );
		}
		
		private function onRemoveObjectFromSceneRequested( e:RemoveObjectFromSceneRequest ):void {
			view.removeFromScene( e.object );
		}
		
		private function onCollision( e:CollisionEvent ):void {
			// collision
		}
		
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