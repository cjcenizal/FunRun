package com.funrun.model {
	
	import com.cenizal.utils.Numbers;
	import com.funrun.model.constants.TrackConstants;
	import org.robotlegs.mvcs.Actor;

	public class DistanceModel extends Actor {
		
		private var _distance:Number = 0;
		
		public function DistanceModel() {
			super();
		}
		
		public function add( amount:Number ):void {
			_distance += amount;
		}
		
		public function reset():void {
			_distance = 0;
		}
		
		public function get distance():Number {
			return Math.round( _distance / TrackConstants.BLOCK_SIZE );
		}
		
		public function get distanceString():String {
			return Numbers.addCommasTo( Math.round( _distance / TrackConstants.BLOCK_SIZE ).toString() );
		}
	}
}
