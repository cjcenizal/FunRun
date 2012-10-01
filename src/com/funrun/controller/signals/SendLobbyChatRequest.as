package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class SendLobbyChatRequest extends Signal
	{
		public function SendLobbyChatRequest()
		{
			super( String );
		}
	}
}