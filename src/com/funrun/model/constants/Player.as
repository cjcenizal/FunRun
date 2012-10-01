package com.funrun.model.constants
{
	import flash.geom.Vector3D;

	public class Player
	{
		// Player movement constants.
		public static const MAX_DODGING_SPEED:Number = 80;//98;
		public static const MAX_SPEED:Number = 80;
		public static const SPEED_CAP:Number = 110;
		public static const JUMP_FORWARD_BOOST:Number = 0;//6;
		public static const ACCELERATION:Number = 2;
		public static const DECELERATION:Number = .5;
		public static const JUMP_SPEED:Number = 110;//100;
		public static const LATERAL_SPEED:Number = 30;
		public static const GRAVITY:Number = -8;
		public static const LAUNCH_SPEED:Number = 150;
		public static const FRICTION:Number = .9;
		public static const FREE_RUN_SPEED:Number = 10;
		public static const SMACK_SPEED:Number = -30;
		
		// Bounds.
		public static const NORMAL_BOUNDS:Vector3D = new Vector3D( 160, 240, 60 );
		public static const DUCKING_BOUNDS:Vector3D = new Vector3D( 160, 120, 60 );
		public static const DUCKING_SCALE:Number = DUCKING_BOUNDS.y / NORMAL_BOUNDS.y;
		
		// Collision constants.
		public static const BOUNCE_OFF_BOTTOM_VELOCITY:Number = -4;
		public static const HEAD_ON_SMACK_SPEED:Number = -160;
		public static const FALL_DEATH_HEIGHT:Number = -1500;
		
		// AI.
		public static const NUM_AI_COMPETITORS:int = 10;
		
		// Position.
		public static const START_POSITION_RANGE:Number = 400;
		public static const START_POSITION_MIN:Number = 100;
	}
}