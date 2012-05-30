package com.funrun.model {
	
	import org.robotlegs.mvcs.Actor;
	
	public class CountdownModel extends Actor {
		
		private var _secondsRemaining:int = 0;
		
		public function set secondsRemaining( val:int ):void {
			_secondsRemaining = val;
		}
		
		public function get secondsRemaining():int {
			return _secondsRemaining;
		}
	}
}
