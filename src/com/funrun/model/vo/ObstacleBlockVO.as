package com.funrun.model.vo {
	
	public class ObstacleBlockVO {
		
		public var id:String;
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function ObstacleBlockVO( id:String, x:Number, y:Number, z:Number ) {
			this.id = id;
			this.x = x;
			this.y = y;
			this.z = z;
		}
	}
}
