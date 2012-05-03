package com.funrun.controller.enum
{
	import com.cenizal.game.patterns.enum.AbstractType;
	import com.cenizal.game.patterns.enum.EnumUtils;

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