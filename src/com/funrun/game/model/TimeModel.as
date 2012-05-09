package com.funrun.game.model {
	
	import com.funrun.game.model.events.TimeEvent;
	
	import flash.display.Stage;
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Actor;
	
	public class TimeModel extends Actor {
		
		private var _isRunning:Boolean = false;
		private var _stage:Stage;
		private var _ticks:int = 0;
		private var _lastTs:int = 0;
		
		public function TimeModel() {
		}
		
		private function onEnterFrame( e:Event ):void {
			var ts:int = new Date().time;
			var delta:int = ts - _lastTs;
			_lastTs = ts;
			dispatch( new TimeEvent( TimeEvent.TICK, _ticks, delta, ts ) );
			_ticks++;
		}
		
		public function start():void {
			if ( _stage ) {
				_lastTs = new Date().time;
				_isRunning = true;
				_stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			}
		}
		
		public function stop():void {
			if ( _stage ) {
				_isRunning = false;
				_stage.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			}
		}
		
		public function set stage( stage:Stage ):void {
			if ( !stage ) {
				trace(this, "Warning: null stage was provided.");
			}
			if ( stage ) {
				if ( _isRunning ) {
					_stage.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				}
			}
			_stage = stage;
			if ( _isRunning ) {
				_stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			}
		}
		
		public function get stage():Stage {
			return _stage;
		}
		
		public function get ticks():int {
			return _ticks;
		}
	}
}