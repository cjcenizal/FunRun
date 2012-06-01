package com.funrun.model {
	
	import com.cenizal.utils.Numbers;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Actor;

	public class DistanceModel extends Actor implements IPlaceable {
		
		private var _distance:Number = 0;
		private var _place:int = 0;
		
		public function DistanceModel() {
			super();
		}
		
		public function add( amount:Number ):void {
			_distance += amount;
		}
		
		public function reset():void {
			_distance = 0;
		}
		
		public function getRelativeDistanceTo( otherPlayerDistance:Number ):Number {
			return otherPlayerDistance - _distance;
		}
		
		public function get distance():Number {
			return _distance;
		}
		
		public function get distanceString():String {
			return Numbers.addCommasTo( Math.round( _distance / TrackConstants.BLOCK_SIZE ).toString() );
		}
		
		public function set place( val:int ):void {
			_place = val;
		}
		
		public function get place():int {
			return _place;
		}
	}
}
