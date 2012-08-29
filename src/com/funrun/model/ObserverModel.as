package com.funrun.model {
	
	import org.robotlegs.mvcs.Actor;
	
	public class ObserverModel extends Actor {
		
		public var competitorId:int;
		
		public function ObserverModel() {
			super();
			reset();
		}
		
		public function reset():void {
			competitorId = -1;
		}
	}
}
