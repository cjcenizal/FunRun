package com.funrun.model {

	import org.robotlegs.mvcs.Actor;

	public class InterpolationModel extends Actor {

		private var _incrementAmount:Number;
		private var _percent:Number = 0;
		
		public function InterpolationModel() {
			super();
		}
		
		public function setIncrement( amount:Number ):void {
			_incrementAmount = amount;
		}
		
		public function increment():void {
			_percent += _incrementAmount;
			if ( _percent > 1 ) _percent = 1;
		}
		
		public function reset():void {
			_percent = 0;
		}
		
		public function get percent():Number {
			return _percent;
		}
	}
}
