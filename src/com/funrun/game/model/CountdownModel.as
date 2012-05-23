package com.funrun.game.model {
	
	import org.robotlegs.mvcs.Actor;
	
	public class CountdownModel extends Actor {
		
		private var _startTime:int;
		
		public function CountdownModel() {
		}
		
		public function start():void {
			_startTime = new Date().getTime();
		}
		
		public function get timeElapsed():int {
			return ( new Date().getTime() ) - _startTime;
		}
		
		public function getTimeRemaining( maxTime:int ):int {
			return maxTime - timeElapsed;
		}
	}
}
