package com.funrun.model.vo
{
	import com.cenizal.physics.collisions.ICollidable;
	
	public class BoundingBoxVO extends CollidableVO implements ICollidable
	{
		public var block:BlockVO;
		
		public function BoundingBoxVO( block:BlockVO, x:Number, y:Number, z:Number, minX:Number, minY:Number, minZ:Number, maxX:Number, maxY:Number, maxZ:Number )
		{
			this.block = block;
			super( x, y, z, minX, minY, minZ, maxX, maxY, maxZ );
		}
		
		override public function add( collidable:ICollidable ):ICollidable {
			return new BoundingBoxVO( block,
				_x + collidable.x,
				_y + collidable.y,
				_z + collidable.z,
				_minX, _minY, minZ,
				_maxX, _maxY, maxZ );
		}
	}
}