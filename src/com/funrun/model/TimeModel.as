package com.funrun.model {
	
	import com.funrun.model.events.TimeEvent;
	
	import flash.display.Stage;
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Actor;
	
	public class TimeModel extends Actor {
		
		private var _isRunning:Boolean = false;
		private var _stage:Stage;
		private var _ticks:int;
		private var _lastTs:int;
		
		public function TimeModel() {
			super();
			reset();
		}
		
		private function onEnterFrame( e:Event ):void {
			var ts:int = new Date().time;
			var delta:int = ts - _lastTs;
			_lastTs = ts;
			dispatch( new TimeEvent( TimeEvent.TICK, _ticks, delta, ts ) );
			_ticks++;
		}
		
		public function init():void {
			if ( _stage ) {
				_lastTs = new Date().time;
				_isRunning = true;
				_stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			}
		}
		
		public function reset():void {
			_ticks = 0;
			_lastTs = 0;
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