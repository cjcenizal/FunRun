package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class UpdateLoadingRequest extends Signal
	{
		public function UpdateLoadingRequest()
		{
			super(String);
		}
	}
}