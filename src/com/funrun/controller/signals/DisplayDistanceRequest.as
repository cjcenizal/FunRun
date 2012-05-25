package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class DisplayDistanceRequest extends Signal
	{
		public function DisplayDistanceRequest()
		{
			super( String );
		}
	}
}