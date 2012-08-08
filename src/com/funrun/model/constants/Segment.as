package com.funrun.model.constants
{
	public class Segment
	{
		public static const NUM_BLOCKS_WIDE:int = 12;
		public static const NUM_BLOCKS_DEPTH:int = 24;
		public static const SEGMENT_WIDTH:int = NUM_BLOCKS_WIDE * Block.SIZE;
		public static const SEGMENT_DEPTH:int = NUM_BLOCKS_DEPTH * Block.SIZE;
		public static const SEGMENT_HALF_WIDTH:Number = SEGMENT_WIDTH * .5;
		public static const SEGMENT_HALF_DEPTH:Number = SEGMENT_DEPTH * .5;
		
		public static const SEGMENT_CULL_DEPTH_NEAR:Number = -2000 -SEGMENT_DEPTH;
		public static const SEGMENT_CULL_DEPTH_FAR:Number = Track.DEPTH + SEGMENT_DEPTH;
		public static const SEGMENT_ADD_DEPTH_NEAR:Number = SEGMENT_DEPTH + SEGMENT_CULL_DEPTH_NEAR;
		public static const SEGMENT_ADD_DEPTH_FAR:Number = Track.DEPTH;
	}
}