package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class UpdateTrackRequest extends Signal
	{
		public function UpdateTrackRequest()
		{
			super( Number );
		}
	}
}