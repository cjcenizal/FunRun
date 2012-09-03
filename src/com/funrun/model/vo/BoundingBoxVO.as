package com.funrun.model.vo
{
	import com.cenizal.physics.collisions.ICollidable;
	
	public class BoundingBoxVo extends CollidableVo implements ICollidable
	{
		public var block:BlockVo;
		
		public function BoundingBoxVo( block:BlockVo, x:Number, y:Number, z:Number, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number )
		{
			this.block = block;
			super( x, y, z, minX, minY, minZ, maxX, maxY, maxZ );
		}
		
		override public function add( collidable:ICollidable ):ICollidable {
			return new BoundingBoxVo( block,
				_x + collidable.x,
				_y + collidable.y,
				_z + collidable.z,
				_minX, _minY, minZ,
				_maxX, _maxY, maxZ );
		}
	}
}