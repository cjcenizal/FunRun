package com.funrun.controller.signals
{
	import away3d.containers.View3D;
	
	import org.osflash.signals.Signal;
	
	public class AddView3DRequest extends Signal
	{
		public function AddView3DRequest()
		{
			super( View3D );
		}
	}
}