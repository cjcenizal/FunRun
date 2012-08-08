package com.funrun.model.constants
{
	public class Track
	{
		// Sizes.
		public static const WIDTH:int = 1200;
		public static const DEPTH:int = 8000;
		public static const WIDTH_BLOCKS:int = WIDTH / Block.SIZE;
		public static const DEPTH_BLOCKS:int = DEPTH / Block.SIZE;
		public static const PLAYER_RADIUS:int = 50;
		public static const PLAYER_HALF_SIZE:int = 55;
		
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