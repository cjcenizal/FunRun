package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class EnablePlayerInputRequest extends Signal
	{
		public function EnablePlayerInputRequest()
		{
			super( Boolean );
		}
	}
}