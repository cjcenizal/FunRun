package com.funrun.controller.signals
{
	import com.funrun.controller.signals.payload.UpdateTrackPayload;
	
	import org.osflash.signals.Signal;
	
	public class UpdateTrackRequest extends Signal
	{
		public function UpdateTrackRequest()
		{
			super( UpdateTrackPayload );
		}
	}
}