package com.funrun.model {

	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Actor;

	public class KeyboardModel extends Actor {
		
		public var stage:Stage;
		
		public function KeyboardModel() {
			super();
		}
		
		public function init():void {
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			eventDispatcher.dispatchEvent( e );
		}
	}
}
