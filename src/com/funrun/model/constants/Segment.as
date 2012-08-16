package com.funrun.model.constants
{
	public class Segment
	{
		public static const WIDTH_BLOCKS:int = 20;
		public static const DEPTH_BLOCKS:int = 24;
		public static const WIDTH:int = WIDTH_BLOCKS * Block.SIZE;
		public static const DEPTH:int = DEPTH_BLOCKS * Block.SIZE;
		public static const HALF_WIDTH:Number = WIDTH * .5;
		public static const HALF_DEPTH:Number = DEPTH * .5;
		
		public static const CULL_DEPTH_NEAR:Number = -2000 -DEPTH;
		public static const CULL_DEPTH_FAR:Number = Track.DEPTH + DEPTH;
		public static const ADD_DEPTH_NEAR:Number = DEPTH + CULL_DEPTH_NEAR;
		public static const ADD_DEPTH_FAR:Number = Track.DEPTH;
		
		public static const FIRST_SEGMENT_Z:Number = 0;// -400; // This caused all the trouble somehow!
		public static const GAP_BETWEEN_SEGMENTS:Number = 10;
		
	}
}