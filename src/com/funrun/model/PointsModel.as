package com.funrun.model
{
	import com.funrun.model.vo.PointVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class PointsModel extends Actor
	{
		
		private var _amount:int;
		private var _collected:Object;
		
		private var _points:Array;
		
		public function PointsModel()
		{
			super();
		}
		
		public function reset():void {
			_amount = 0;
			_collected = {};
			_points = [];
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
		
		public function addPoint( point:PointVo ):void {
			_points.push( point );
			var len:int = _points.length;
			_points.sortOn( "meshZ", [ Array.NUMERIC ] );
		}
		
		public function getPointAt( index:int ):PointVo {
			return _points[ index ];
		}
		
		public function removePointAt( index:int ):void {
			_points.splice( index, 1 );
		}
		
		public function get numPoints():int {
			return _points.length;
		}
		
		public function get amount():int {
			return _amount;
		}
	}
}