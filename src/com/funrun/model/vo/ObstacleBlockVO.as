package com.funrun.model.vo {
	
	public class ObstacleBlockVo {
		
		public var type:String;
		public var pos:String;
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function ObstacleBlockVo( type:String, pos:String, x:Number, y:Number, z:Number ) {
			this.type = type;
			this.pos = pos;
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function toString():String {
			return (type + " " + pos + ": " + x + ", " + y + ", " + z);
		}
	}
}
