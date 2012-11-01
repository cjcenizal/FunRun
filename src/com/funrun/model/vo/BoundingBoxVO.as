package com.funrun.model.vo
{
	import com.cenizal.physics.collisions.ICollidable;
	
	public class BoundingBoxVo extends CollidableVo implements ICollidable
	{
		public var id:int;
		public var block:BlockTypeVo;
		
		public function BoundingBoxVo( id:int, block:BlockTypeVo, x:Number, y:Number, z:Number, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number )
		{
			this.id = id;
			this.block = block;
			super( x, y, z, minX, minY, minZ, maxX, maxY, maxZ );
		}
		
		override public function add( collidable:ICollidable ):ICollidable {
			return new BoundingBoxVo( id, block,
				_x + collidable.x,
				_y + collidable.y,
				_z + collidable.z,
				_minX, _minY, minZ,
				_maxX, _maxY, maxZ );
		}
	}
}