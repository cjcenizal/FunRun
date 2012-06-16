package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class CullSegmentsRequest extends Signal
	{
		public function CullSegmentsRequest()
		{
			super( Number );
		}
	}
}