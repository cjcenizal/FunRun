package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	import playerio.Message;
	
	public class HandleLobbyWelcomeRequest extends Signal
	{
		public function HandleLobbyWelcomeRequest()
		{
			super( Message );
		}
	}
}