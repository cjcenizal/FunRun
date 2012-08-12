package com.funrun.model.constants
{
	import flash.geom.Vector3D;

	public class Player
	{
		// Player movement constants.
		public static const MAX_FORWARD_VELOCITY:Number = 60;
		public static const SLOWED_DIAGONAL_SPEED:Number = 55;//45;
		public static const FOWARD_ACCELERATION:Number = 1;
		public static const JUMP_SPEED:Number = 90;//84;
		public static const LATERAL_SPEED:Number = 30;
		public static const GRAVITY:Number = -8;
		public static const LAUNCH_SPEED:Number = 150;
		
		// Size.
		public static const HEIGHT:Number = 180;
		public static const WIDTH:Number = 100;
		public static const HALF_WIDTH:Number = WIDTH * .5;
		public static const HALF_HEIGHT:Number = HEIGHT * .5 - 5;
		
		// Bounds.
		public static const NORMAL_BOUNDS:Vector3D = new Vector3D( 100, 180, 60 );
		public static const DUCKING_BOUNDS:Vector3D = new Vector3D( 100, 80, 60 );
		
	}
}