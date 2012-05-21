package com.funrun.game.model {

	import org.robotlegs.mvcs.Actor;

	public class DistanceModel extends Actor {
		
		public var distance:Number = 0;
		
		public function DistanceModel() {
			super();
		}
		
		public function add( amount:Number ):void {
			distance += amount;
		}
	}
}
