package com.funrun.model.vo
{
	import com.cenizal.physics.collisions.ICollidable;
	
	public class CollidableVo implements ICollidable
	{
		
		protected var _x:Number;
		protected var _y:Number;
		protected var _z:Number;
		protected var _minX:Number;
		protected var _minY:Number;
		protected var _minZ:Number;
		protected var _maxX:Number;
		protected var _maxY:Number;
		protected var _maxZ:Number;
		
		public function CollidableVo( x:Number = 0, y:Number = 0, z:Number = 0, minX:Number = 0, minY:Number = 0, minZ:Number = 0, maxX:Number = 0, maxY:Number = 0, maxZ:Number = 0 )
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
		
		public function toString():String {
			return "(" + _x + ", " + _y + ", " + _z + ") - (X: " + Math.round(worldMinX) + ", " + Math.round(worldMaxX) + "), (Y: " + Math.round(worldMinY) + ", " + Math.round(worldMaxY) + "), (Z: " + Math.round(worldMinZ) + ", " + Math.round(worldMaxZ) + ")";
		}
		
		public function add( collidable:ICollidable ):ICollidable {
			return new CollidableVo(
				_x + collidable.x,
				_y + collidable.y,
				_z + collidable.z,
				_minX, _minY, minZ,
				_maxX, _maxY, maxZ );
		}
		
		public function copyFrom( collidable:ICollidable ):void {
			_x = collidable.x;
			_y = collidable.y;
			_z = collidable.z;
			_minX = collidable.minX;
			_minY = collidable.minY;
			_minZ = collidable.minZ;
			_maxX = collidable.maxX;
			_maxY = collidable.maxY;
			_maxZ = collidable.maxZ;
		}
		
		public function takeMinFrom( collidable:ICollidable ):void {
			if ( collidable.worldMinX < this.worldMinX ) {
				_x = collidable.x;
				_minX = collidable.minX;
			}
			if ( collidable.worldMinY < this.worldMinY ) {
				_y = collidable.y;
				_minY = collidable.minY;
			}
			if ( collidable.worldMinZ < this.worldMinZ ) {
				_z = collidable.z;
				_minZ = collidable.minZ;
			}
		}
		
		public function takeMaxFrom( collidable:ICollidable ):void {
			if ( collidable.worldMaxX > this.worldMaxX ) {
				_x = collidable.x;
				_maxX = collidable.maxX;
			}
			if ( collidable.worldMaxY > this.worldMaxY ) {
				_y = collidable.y;
				_maxY = collidable.maxY;
			}
			if ( collidable.worldMaxZ > this.worldMaxZ ) {
				_z = collidable.z;
				_maxZ = collidable.maxZ;
			}
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
		
		public function get worldMinX():Number
		{
			return _x + _minX;
		}
		
		public function get worldMinY():Number
		{
			return _y + _minY;
		}
		
		public function get worldMinZ():Number
		{
			return _z + _minZ;
		}
		
		public function get worldMaxX():Number
		{
			return _x + _maxX;
		}
		
		public function get worldMaxY():Number
		{
			return _y + _maxY;
		}
		
		public function get worldMaxZ():Number
		{
			return _z + _maxZ;
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
		
		public function get width():Number {
			return this._maxX - this.minX;
		}
		
		public function get height():Number {
			return this._maxY - this.minY;
		}
		
		public function get depth():Number {
			return this._maxZ - this.minZ;
		}
	}
}