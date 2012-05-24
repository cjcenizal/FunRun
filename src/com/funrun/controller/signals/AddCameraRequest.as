package com.funrun.controller.signals
{
	import away3d.cameras.Camera3D;
	
	import org.osflash.signals.Signal;
	
	public class AddCameraRequest extends Signal
	{
		public function AddCameraRequest()
		{
			super( Camera3D );
		}
	}
}