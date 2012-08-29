package com.funrun.model {
	
	import org.robotlegs.mvcs.Actor;
	
	public class CountdownModel extends Actor {
		
		private var _startTime:Number = 0;
		private var _msRemaining:Number = 7;
		private var _isRunning:Boolean = false;
		
		public function start( msRemaining:Number ):void {
			_isRunning = true;
			_msRemaining = msRemaining;
			var date:Date = new Date();
			_startTime = date.getTime();
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
