package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class DrawPointsRequest extends Signal
	{
		public function DrawPointsRequest()
		{
			super( String );
		}
	}
}