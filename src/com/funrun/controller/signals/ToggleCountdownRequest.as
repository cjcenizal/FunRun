package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class ToggleCountdownRequest extends Signal
	{
		public function ToggleCountdownRequest()
		{
			super( Boolean );
		}
	}
}