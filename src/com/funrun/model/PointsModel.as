package com.funrun.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class PointsModel extends Actor
	{
		
		private var _amount:int;
		private var _collected:Object;
		
		public function PointsModel()
		{
			super();
		}
		
		public function reset():void {
			_amount = 0;
			_collected = {};
		}
		
		public function collectFor( segmentId:int, blockId:int, amount:int ):Boolean {
			var key:String = segmentId.toString() + "-" + blockId.toString();
			if ( !_collected[ key ] ) {
				_collected[ key ] = true;
				_amount += amount;
				return true;
			}
			return false;
		}
		
		public function get amount():int {
			return _amount;
		}
	}
}