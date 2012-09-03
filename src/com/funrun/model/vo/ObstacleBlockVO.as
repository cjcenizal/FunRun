package com.funrun.model.vo {
	
	public class ObstacleBlockVo {
		
		public var id:String;
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function ObstacleBlockVo( id:String, x:Number, y:Number, z:Number ) {
			this.id = id;
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function toString():String {
			return (id + ": " + x + ", " + y + ", " + z);
		}
	}
}
