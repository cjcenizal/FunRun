package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class DrawDistanceRequest extends Signal
	{
		public function DrawDistanceRequest()
		{
			super( String );
		}
	}
}