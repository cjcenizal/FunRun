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
		public static const FOG_FAR:Number = DEPTH;
		public static const FOG_NEAR:Number = FOG_FAR - 600;
		
		// Culling.
		public static const CULL_FLOOR:int = -100000;
		public static const CULL_DEPTH_NEAR:Number = -Track.DEPTH - DEPTH;
		public static const CULL_DEPTH_FAR:Number = Track.DEPTH + DEPTH;
		public static const ADD_DEPTH_NEAR:Number = DEPTH + CULL_DEPTH_NEAR;
		public static const ADD_DEPTH_FAR:Number = Track.DEPTH;
	}
}