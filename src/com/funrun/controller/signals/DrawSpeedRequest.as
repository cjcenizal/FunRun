package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class DrawSpeedRequest extends Signal
	{
		public function DrawSpeedRequest()
		{
			super( Number );
		}
	}
}