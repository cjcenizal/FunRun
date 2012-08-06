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
		
		// Camera.
		public static const CAM_Y:Number = 800;
		public static const CAM_Z:Number = -1000;
		public static const CAM_FOV:Number = 60;
		public static const CAM_TILT:Number = 20;
		public static const CAM_FRUSTUM_DISTANCE:Number = 8000; // the higher the value, the blockier the shadows
		
		// Player movement constants.
		public static const MAX_PLAYER_FORWARD_VELOCITY:Number = 60;
		public static const SLOWED_DIAGONAL_SPEED:Number = 55;//45;
		public static const PLAYER_FOWARD_ACCELERATION:Number = 1;
		public static const PLAYER_JUMP_SPEED:Number = 90;//84;
		public static const PLAYER_LATERAL_SPEED:Number = 30;
		public static const PLAYER_GRAVITY:Number = -8;
		
		// Segment constants.
		public static const SEGMENT_CULL_DEPTH_NEAR:Number = -2000 -Segment.SEGMENT_DEPTH;
		public static const SEGMENT_CULL_DEPTH_FAR:Number = DEPTH + Segment.SEGMENT_DEPTH;
		public static const SEGMENT_ADD_DEPTH_NEAR:Number = Segment.SEGMENT_DEPTH + SEGMENT_CULL_DEPTH_NEAR;
		public static const SEGMENT_ADD_DEPTH_FAR:Number = DEPTH;
		
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