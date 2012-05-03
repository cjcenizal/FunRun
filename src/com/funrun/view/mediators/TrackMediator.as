package com.funrun.view.mediators
{
	import com.funrun.view.components.Track;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class TrackMediator extends Mediator implements IMediator
	{
		[Inject]
		public var view:Track;
		private var stage:Stage;
		
		override public function onRegister():void {
			view.init();
			view.addStats();
			start();
		}
		
		private function start():void {
			view.start();
			stage = view.stage;
			stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		
		private function onEnterFrame( e:Event ):void {
			view.update();
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			switch ( e.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					view.jump();
					break;
				case Keyboard.LEFT:
					view.startMovingLeft();
					break;
				case Keyboard.RIGHT:
					view.startMovingRight();
					break;
				case Keyboard.DOWN:
					view.startDucking();
					break;
			}	
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			if ( !stage.hasEventListener( Event.ENTER_FRAME ) ) {
				stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			}
			switch ( e.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					view.stopJumping();
					break;
				case Keyboard.LEFT:
					view.stopMovingLeft();
					break;
				case Keyboard.RIGHT:
					view.stopMovingRight();
					break;
				case Keyboard.DOWN:
					view.stopDucking();
					break;
			}
			
		}
	}
}