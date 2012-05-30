package com.funrun.model.constants {

	public class TimeConstants {

		public static const FPS:Number = 30;
		public static const MS_PER_SERVER_UPDATE:Number = 100;
		public static const FPU:Number = FPS / 1000.0 * MS_PER_SERVER_UPDATE;
		public static const INTERPOLATION_INCREMENT:Number = 1 / FPU;
	}
}
