package com.cenizal.physics.collisions
{
	public interface ICollidable
	{
		function get x():Number;
		function get y():Number;
		function get z():Number;
		function set x( x:Number ):void;
		function set y( y:Number ):void;
		function set z( z:Number ):void;
		function get minX():Number;
		function get minY():Number;
		function get minZ():Number;
		function get maxX():Number;
		function get maxY():Number;
		function get maxZ():Number;
		function get worldMinX():Number;
		function get worldMinY():Number;
		function get worldMinZ():Number;
		function get worldMaxX():Number;
		function get worldMaxY():Number;
		function get worldMaxZ():Number;
		function add( collidable:ICollidable ):ICollidable;
	}
}