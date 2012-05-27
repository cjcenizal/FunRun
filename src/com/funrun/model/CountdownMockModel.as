package com.funrun.model {

	import org.robotlegs.mvcs.Actor;

	public class CountdownMockModel extends Actor {
		
		private var _startTime:int;
		private var _maxSeconds:int;

		public function start( maxSeconds:int ):void {
			_maxSeconds = maxSeconds;
			_startTime = new Date().getTime();
		}

		private function get timeElapsed():int {
			return ( new Date().getTime() ) - _startTime;
		}

		public function get secondsRemaining():int {
			return Math.ceil( ( ( _maxSeconds * 1000 ) - timeElapsed ) * .001 );
		}
	}
}
