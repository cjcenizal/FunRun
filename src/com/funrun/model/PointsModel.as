package com.funrun.model {

	import org.robotlegs.mvcs.Actor;

	public class PointsModel extends Actor {
		
		private var _placeValues:Object;
		private var _minValue:Number = 100000;
		
		public function PointsModel() {
			super();
			_placeValues = {};
		}
		
		public function assign( place:int, value:Number ):void {
			_placeValues[ place ] = value;
			if ( value < _minValue ) _minValue = value;
		}
		
		public function retrieveValue( place:int ):Number {
			return _placeValues[ place ];
		}
		
		public function hasValue( place:int ):Boolean {
			return _placeValues[ place ];
		}
		
		public function get minValue():Number {
			return _minValue;
		}
	}
}
