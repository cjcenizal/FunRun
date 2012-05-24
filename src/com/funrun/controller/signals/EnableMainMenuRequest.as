package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class EnableMainMenuRequest extends Signal
	{
		public function EnableMainMenuRequest()
		{
			super( Boolean );
		}
	}
}