package com.funrun.model.constants
{
	import away3d.materials.ColorMaterial;

	public class Materials
	{
		private static const ALPHA:Number = 1;
		public static const DEBUG_PLAYER:ColorMaterial = new ColorMaterial( 0xff0000, ALPHA );
		public static const DEBUG_BLOCK:ColorMaterial = new ColorMaterial( 0x00ff00, ALPHA );
	}
}