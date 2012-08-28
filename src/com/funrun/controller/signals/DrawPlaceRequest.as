package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class DrawPlaceRequest extends Signal
	{
		public function DrawPlaceRequest()
		{
			super( String );
		}
	}
}