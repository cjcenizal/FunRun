package com.funrun.model
{
	import com.funrun.model.vo.PointVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class PointsModel extends Actor
	{
		
		private var _amount:int;
		private var _collected:Object;
		
		private var _points:Array;
		private var _pointsObj:Object;
		
		public function PointsModel()
		{
			super();
		}
		
		public function reset():void {
			_amount = 0;
			_collected = {};
			_points = [];
			_pointsObj = {};
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
			_pointsObj[ point.segmentId.toString() + "-" + point.id.toString() ] = point;
		}
		
		public function getPointAt( index:int ):PointVo {
			return _points[ index ];
		}
		
		public function removePointAt( index:int ):void {
			var point:PointVo = getPointAt( index );
			delete _pointsObj[ point.segmentId.toString() + "-" + point.id.toString() ];
			_points.splice( index, 1 );
		}
		
		public function hasPointFor( segmentId:int, pointId:int ):Boolean {
			return _pointsObj[ segmentId.toString() + "-" + pointId.toString() ];
		}
		
		public function get numPoints():int {
			return _points.length;
		}
		
		public function get amount():int {
			return _amount;
		}
	}
}