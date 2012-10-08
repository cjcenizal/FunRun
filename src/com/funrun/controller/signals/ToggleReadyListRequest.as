package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class ToggleReadyListRequest extends Signal
	{
		public function ToggleReadyListRequest()
		{
			super( Boolean );
		}
	}
}