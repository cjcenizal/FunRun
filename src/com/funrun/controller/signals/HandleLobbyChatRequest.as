package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	import playerio.Message;

	
	public class HandleLobbyChatRequest extends Signal
	{
		public function HandleLobbyChatRequest()
		{
			super( Message );
		}
	}
}