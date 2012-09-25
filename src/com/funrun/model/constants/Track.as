package com.funrun.model.constants
{
	public class Track
	{
		// Sizes.
		public static const WIDTH_BLOCKS:int = Width.WIDTH_BLOCKS;
		public static const DEPTH_BLOCKS:int = 80;
		public static const WIDTH:int = WIDTH_BLOCKS * Block.SIZE;
		public static const DEPTH:int = DEPTH_BLOCKS * Block.SIZE;
		
		// Fog.
		public static const FOG_FAR:Number = 9000;
		public static const FOG_NEAR:Number = FOG_FAR - 6000;
		
		// Culling.
		public static const CULL_FLOOR:int = -100000;
		public static const CULL_DEPTH_NEAR:Number = DEPTH * -2;
		public static const CULL_DEPTH_FAR:Number = DEPTH * 2;
	}
}