package com.funrun.model.constants
{
	public class Animations
	{
		public static const RUN:String = "run";
		public static const JUMP:String = "jump";
		public static const IDS:Array = [ RUN, JUMP ];
		public static var IS_LOOPING:Object = {};
		IS_LOOPING[ RUN ] = true;
		IS_LOOPING[ JUMP ] = false;
	}
}