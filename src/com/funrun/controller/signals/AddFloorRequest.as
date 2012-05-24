package com.funrun.controller.signals
{
	import com.funrun.controller.signals.payload.AddFloorPayload;
	
	import org.osflash.signals.Signal;
	
	public class AddFloorRequest extends Signal
	{
		/**
		 * Dispatch expects AddFloorPayload.
		 */
		public function AddFloorRequest()
		{
			super( AddFloorPayload );
		}
	}
}