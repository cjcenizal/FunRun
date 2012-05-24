package com.funrun.controller.signals
{
	import away3d.containers.ObjectContainer3D;
	
	import org.osflash.signals.Signal;
	
	public class RemoveObjectFromSceneRequest extends Signal
	{
		public function RemoveObjectFromSceneRequest()
		{
			super( ObjectContainer3D );
		}
	}
}