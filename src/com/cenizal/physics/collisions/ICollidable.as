package com.cenizal.physics.collisions
{
	public interface ICollidable
	{
		function get x():Number;
		function get y():Number;
		function get z():Number;
		function get minX():Number;
		function get minY():Number;
		function get minZ():Number;
		function get maxX():Number;
		function get maxY():Number;
		function get maxZ():Number;
	}
}