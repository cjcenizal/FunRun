package com.funrun.model {

	import org.robotlegs.mvcs.Actor;

	public class RewardsModel extends Actor {
		
		private var _placeValues:Object;
		private var _minValue:Number = 100000;
		
		public function RewardsModel() {
			super();
			_placeValues = {};
		}
		
		public function assignRewardFor( place:int, value:Number ):void {
			_placeValues[ place ] = value;
			if ( value < _minValue ) _minValue = value;
		}
		
		public function retrieveRewardFor( place:int ):Number {
			return _placeValues[ place ];
		}
		
		public function hasValueFor( place:int ):Boolean {
			return _placeValues[ place ];
		}
		
		public function get minValue():Number {
			return _minValue;
		}
	}
}
