package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class DrawCountdownRequest extends Signal
	{
		public function DrawCountdownRequest()
		{
			super( String );
		}
	}
}