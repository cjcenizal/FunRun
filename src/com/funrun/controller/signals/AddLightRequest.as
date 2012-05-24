package com.funrun.controller.signals
{
	import away3d.lights.LightBase;
	
	import org.osflash.signals.Signal;
	
	public class AddLightRequest extends Signal
	{
		
		public function AddLightRequest()
		{
			super( String, LightBase );
		}
	}
}