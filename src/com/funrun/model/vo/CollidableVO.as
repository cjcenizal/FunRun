package com.funrun.model.vo
{
	import com.cenizal.physics.collisions.ICollidable;
	
	public class CollidableVO implements ICollidable
	{
		
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		private var _minX:Number;
		private var _minY:Number;
		private var _minZ:Number;
		private var _maxX:Number;
		private var _maxY:Number;
		private var _maxZ:Number;
		
		public function CollidableVO( x:Number = 0, y:Number = 0, z:Number = 0, minX:Number = 0, minY:Number = 0, minZ:Number = 0, maxX:Number = 0, maxY:Number = 0, maxZ:Number = 0 )
		{
			_x = x;
			_y = y;
			_z = z;
			_minX = minX;
			_minY = minY;
			_minZ = minZ;
			_maxX = maxX;
			_maxY = maxY;
			_maxZ = maxZ;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function get z():Number
		{
			return _z;
		}
		
		public function get minX():Number
		{
			return _minX;
		}
		
		public function get minY():Number
		{
			return _minY;
		}
		
		public function get minZ():Number
		{
			return _minZ;
		}
		
		public function get maxX():Number
		{
			return _maxX;
		}
		
		public function get maxY():Number
		{
			return _maxY;
		}
		
		public function get maxZ():Number
		{
			return _maxZ;
		}
		
		public function set x( x:Number ):void {
			this._x = x;
		}
		
		public function set y( y:Number ):void {
			this._y = y;
		}
		
		public function set z( z:Number ):void {
			this._z = z;
		}
		
		public function set minX( minX:Number ):void {
			this._minX = minX;
		}
		
		public function set minY( minY:Number ):void {
			this._minY = minY;
		}
		
		public function set minZ( minZ:Number ):void {
			this._minZ = minZ;
		}
		
		public function set maxX( maxX:Number ):void {
			this._maxX = maxX;
		}

		public function set maxY( maxY:Number ):void {
			this._maxY = maxY;
		}
		public function set maxZ( maxZ:Number ):void {
			this._maxZ = maxZ;
		}
	}
}