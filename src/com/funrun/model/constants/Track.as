package com.funrun.model.constants
{
	public class Track
	{
		// Sizes.
		public static const WIDTH_BLOCKS:int = 20;
		public static const DEPTH_BLOCKS:int = 80;
		public static const WIDTH:int = WIDTH_BLOCKS * Block.SIZE;//1200;
		public static const DEPTH:int = DEPTH_BLOCKS * Block.SIZE;//8000;
		
		// Collision constants.
		public static const BOUNCE_OFF_BOTTOM_VELOCITY:Number = -4;
		public static const HEAD_ON_SMACK_SPEED:Number = -160;
		public static const FALL_DEATH_HEIGHT:Number = -1500;
		
		// Fog.
		public static const FOG_FAR:Number = DEPTH;
		public static const FOG_NEAR:Number = FOG_FAR - 2000;
		
		// Culling.
		public static const CULL_FLOOR:int = -100000;
	}
}