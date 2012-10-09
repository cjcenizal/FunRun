package com.funrun.model.constants {

	public class Time {

		public static const FPS:Number = 30;
		public static const MS_PER_SERVER_UPDATE:Number = 100;
		public static const FPU:Number = FPS / 1000.0 * MS_PER_SERVER_UPDATE;
		public static const INTERPOLATION_INCREMENT:Number = 1 / FPU;
		
		public static const COUNTDOWN_SECONDS:int = 5;
		public static const COUNTDOWN_WAIT_SECONDS:int = 5;
	}
}
