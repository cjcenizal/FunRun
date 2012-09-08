package com.funrun.model
{
	import com.funrun.model.vo.PointVo;
	import com.gskinner.utils.Rndm;
	
	import org.robotlegs.mvcs.Actor;
	
	public class PointsModel extends Actor
	{
		
		private var _amount:int;
		private var _collected:Object;
		
		private var _points:Array;
		private var _pointsObj:Object;
		
		private var _history:Object;
		private var _random:Rndm;
		
		public function PointsModel()
		{
			super();
			_random = new Rndm( Math.floor( Math.random() * 100 ) );
		}
		
		public function reset():void {
			_amount = 0;
			_collected = {};
			_points = [];
			_pointsObj = {};
			_history = {};
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
		
		public function shouldHavePointFor( segmentId:int, pointId:int ):Boolean {
			if ( !_history[ segmentId ] ) _history[ segmentId ] = {};
			if ( !_history[ segmentId ][ pointId ] ) _history[ segmentId ][ pointId ] = ( _random.random() < .5 );
			return _history[ segmentId ][ pointId ];
		}
		
		public function get numPoints():int {
			return _points.length;
		}
		
		public function get amount():int {
			return _amount;
		}
	}
}