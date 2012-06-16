package com.funrun.controller.signals
{
	import com.funrun.controller.signals.payload.AddSegmentPayload;
	
	import org.osflash.signals.Signal;
	
	public class AddObstacleRequest extends Signal
	{
		public function AddObstacleRequest()
		{
			super( AddSegmentPayload );
		}
	}
}