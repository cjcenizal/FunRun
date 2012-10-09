package com.funrun.model {
	
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CountdownModel extends Actor {
		
		private var _startTime:Number = 0;
		private var _msRemaining:Number = 7;
		private var _isRunning:Boolean = false;
		private var _delayed:Boolean = false;
		private var _timeOut:uint;
		
		public function delayedStart( waitSeconds:int, callback:Function ):void {
			clearDelay();
			_delayed = true;
			_timeOut = setTimeout( callback, waitSeconds );
		}
		
		public function start( countdownSeconds:int ):void {
			clearDelay();
			_isRunning = true;
			_msRemaining = countdownSeconds * 1000;
			var date:Date = new Date();
			_startTime = date.getTime();
		}
		
		private function clearDelay():void {
			if ( _delayed ) {
				_delayed = false;
				clearTimeout( _timeOut );
			}
		}
		
		public function reset():void {
			_isRunning = false;
		}
		
		public function get secondsRemaining():Number {
			return Math.ceil( ( ( _msRemaining ) - msElapsed ) * .001 );
		}
		
		private function get msElapsed():Number {
			var date:Date = new Date();
			return ( date.getTime() ) - _startTime;
		}
		
		public function get isRunning():Boolean {
			return _isRunning;
		}
		
	}
}
