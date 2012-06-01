package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class DisplayPlaceRequest extends Signal
	{
		public function DisplayPlaceRequest()
		{
			super( String );
		}
	}
}