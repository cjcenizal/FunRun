package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class KillPlayerRequest extends Signal
	{
		public function KillPlayerRequest()
		{
			super( String );
		}
	}
}