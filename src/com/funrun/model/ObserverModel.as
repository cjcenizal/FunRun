package com.funrun.model {
	
	import org.robotlegs.mvcs.Actor;
	
	public class ObserverModel extends Actor {
		
		public var competitorId:int;
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function ObserverModel() {
			super();
			reset();
		}
		
		public function reset():void {
			competitorId = -1;
			x = y = z = 0;
		}
	}
}
