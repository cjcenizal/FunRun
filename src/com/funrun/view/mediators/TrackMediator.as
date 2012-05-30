package com.funrun.view.mediators
{
	import away3d.containers.View3D;
	
	import com.funrun.controller.signals.AddView3DRequest;
	import com.funrun.controller.signals.EnablePlayerInputRequest;
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
		public var enablePlayerInputRequest:EnablePlayerInputRequest;
		
		[Inject]
		public var addView3DRequest:AddView3DRequest;
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		private var stage:Stage;
		
		override public function onRegister():void {
			stage = view.stage;
			view.init();
			view.debug();
			addView3DRequest.add( onAddView3DRequested );
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
		
		private function onAddView3DRequested( view3D:View3D ):void {
			this.view.view3D = view3D;
		}
		
		/**
		 * Render the scene.
		 */
		private function onRenderSceneRequested():void {
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