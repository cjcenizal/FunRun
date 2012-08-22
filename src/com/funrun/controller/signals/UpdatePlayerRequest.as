package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class UpdatePlayerRequest extends Signal
	{
		public function UpdatePlayerRequest()
		{
			super( int );
		}
	}
}