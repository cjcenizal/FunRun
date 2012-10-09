package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class ToggleReadyButtonRequest extends Signal
	{
		public function ToggleReadyButtonRequest()
		{
			super( Boolean );
		}
	}
}