package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class ResetPlayerRequest extends Signal
	{
		public function ResetPlayerRequest()
		{
			super( Boolean );
		}
	}
}