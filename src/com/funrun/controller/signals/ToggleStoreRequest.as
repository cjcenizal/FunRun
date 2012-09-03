package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class ToggleStoreRequest extends Signal
	{
		public function ToggleStoreRequest()
		{
			super( Boolean );
		}
	}
}