package com.funrun.game.model.parsers {
	import flash.geom.Point;
	
	public class PositionParser extends AbstractParser {
		
		private const POS:String = "pos";
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		
		public function PositionParser( data:Object ) {
			super( data );
			_x = data[ POS ][ 0 ];
			_y = data[ POS ][ 1 ];
			_z = data[ POS ][ 2 ];
		}
		
		public function get x():Number {
			return _x;
		}
		
		public function get y():Number {
			return _y;
		}
		
		public function get z():Number {
			return _z;
		}
	}
}
