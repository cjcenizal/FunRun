package com.funrun.controller.signals
{
	import com.funrun.controller.signals.payload.AddObstaclePayload;
	
	import org.osflash.signals.Signal;
	
	public class AddObstacleRequest extends Signal
	{
		public function AddObstacleRequest()
		{
			super( AddObstaclePayload );
		}
	}
}