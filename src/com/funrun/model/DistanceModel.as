package com.funrun.model {
	
	import com.cenizal.utils.Numbers;
	import org.robotlegs.mvcs.Actor;

	public class DistanceModel extends Actor {
		
		public var distance:Number = 0;
		
		public function DistanceModel() {
			super();
		}
		
		public function add( amount:Number ):void {
			distance += amount;
		}
		
		public function distanceString():String {
			return Numbers.addCommasTo( ( Math.round( distance * .05 ) ).toString() );
		}
	}
}
