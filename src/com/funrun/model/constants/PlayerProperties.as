package com.funrun.model.constants {

	public class PlayerProperties {

		public static const HIGH_SCORE:String = "hs";
		public static const POINTS:String = "pts";
		public static const COLOR:String = "col";
		public static const CHARACTER:String = "char";
		public static const KEYS:Array = [
			HIGH_SCORE,
			POINTS,
			COLOR,
			CHARACTER
		];
		public static const DEFAULTS:Object = {};
		DEFAULTS[ HIGH_SCORE	]	= 0,
		DEFAULTS[ POINTS ]			= 0;
		DEFAULTS[ COLOR ]			= "red";
		DEFAULTS[ CHARACTER ]		= "0";
	}
}
