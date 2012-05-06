package com.funrun.game.model.parsers {
	import flash.geom.Point;
	
	public class ObstacleBlockParser extends AbstractParser {
		
		private var _id:String;
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		
		public function ObstacleBlockParser( data:Object ) {
			super( data );
			_id = new IdParser( data ).id;
			var position:PositionParser = new PositionParser( data );
			_x = position.x;
			_y = position.y;
			_z = position.z;
		}
		
		public function get id():String {
			return _id;
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
