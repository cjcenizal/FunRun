package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class ShowLoadingRequest extends Signal
	{
		public function ShowLoadingRequest()
		{
			super( String );
		}
	}
}