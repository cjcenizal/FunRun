package com.funrun.model {
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Actor;

	public class KeyboardModel extends Actor {
		
		public var stage:Stage;
		private var _numKeysDown:int = 0;
		
		public function KeyboardModel() {
			super();
		}
		
		public function init():void {
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			stage.addEventListener( Event.DEACTIVATE, onDeactivate );
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			_numKeysDown++;
			eventDispatcher.dispatchEvent( e );
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			_numKeysDown--;
			eventDispatcher.dispatchEvent( e );
		}
		
		private function onDeactivate( e:Event ):void {
			// TO-DO: Somehow we need to alert the game that keyboard input has been deactivated.
		}
		
		public function get numKeysDown():int {
			return _numKeysDown;
		}
	}
}
