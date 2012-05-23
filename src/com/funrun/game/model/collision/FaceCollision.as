package com.funrun.game.model.collision {
	
	import com.funrun.game.services.parsers.BlockParser;

	public class FaceCollision {
		
		public var type:String;
		public var event:String;
		public var minX:Number;
		public var minY:Number;
		public var minZ:Number;
		public var maxX:Number;
		public var maxY:Number;
		public var maxZ:Number;

		public function FaceCollision( type:String, event:String, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number ) {
			this.type = type;
			this.event = event;
			this.minX = minX;
			this.minY = minY;
			this.minZ = minZ;
			this.maxX = maxX;
			this.maxY = maxY;
			this.maxZ = maxZ;
		}
	}
}
