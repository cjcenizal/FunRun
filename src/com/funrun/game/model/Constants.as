package com.funrun.game.model
{
	public class Constants
	{
		// Sizes.
		public static const BLOCK_SIZE:Number = 100;
		public static const TRACK_WIDTH:int = 1200;
		public static const TRACK_LENGTH:int = 5000;
		
		// Camera.
		public static const CAM_Y:Number = 800;
		public static const CAM_Z:Number = -1000;
		public static const CAM_FOV:Number = 60;
		public static const CAM_TILT:Number = 20;
		public static const CAM_FRUSTUM_DISTANCE:Number = 6000; // the higher the value, the blockier the shadows
		
		// Player movement constants.
		public static const PLAYER_JUMP_SPEED:Number = 72;
		public static const PLAYER_LATERAL_SPEED:Number = BLOCK_SIZE * .2;
		public static const PLAYER_JUMP_GRAVITY:Number = -8;
		public static const MAX_PLAYER_FORWARD_VELOCITY:Number = 40;
		
		// Obstacle creation constants.
		public static const OBSTACLE_START_DEPTH:Number = 50 * BLOCK_SIZE;
		public static const OBSTACLE_CREATION_INTERVAL:Number = 15 * BLOCK_SIZE;
		public static const ADD_OBSTACLE_DEPTH:Number = OBSTACLE_START_DEPTH - OBSTACLE_CREATION_INTERVAL;
		public static const REMOVE_OBSTACLE_DEPTH:Number = -10 * BLOCK_SIZE;
	}
}