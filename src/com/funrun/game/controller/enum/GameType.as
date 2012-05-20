package com.funrun.game.controller.enum
{
	import com.cenizal.patterns.enum.AbstractType;
	import com.cenizal.patterns.enum.EnumUtils;

	public class GameType extends AbstractType
	{
		/**
		 * Static constructor.
		 */
		{
			EnumUtils.initEnumConstants( GameType );
		}
		
		public static const Local:GameType = new GameType();
		public static const Production:GameType = new GameType();
	}
}