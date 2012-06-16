package com.funrun.controller.signals
{
	import com.funrun.controller.signals.payload.AddSegmentPayload;
	
	import org.osflash.signals.Signal;
	
	public class AddSegmentRequest extends Signal
	{
		public function AddSegmentRequest()
		{
			super( AddSegmentPayload );
		}
	}
}