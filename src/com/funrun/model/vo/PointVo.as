package com.funrun.model.vo
{
	import away3d.entities.Mesh;

	public class PointVo
	{
		
		public var id:int;
		public var block:BlockTypeVo;
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public var mesh:Mesh;
		public var segmentId:int;
		
		public function PointVo( id:int, block:BlockTypeVo, x:Number, y:Number, z:Number )
		{
			this.id = id;
			this.block = block;
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function clone():PointVo {
			return new PointVo( id, block, x, y, z );
		}
		
		public function get meshZ():Number {
			return mesh.z;
		}
	}
}