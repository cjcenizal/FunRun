package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	import playerio.Message;
	
	public class HandleLobbyPlayerLeftRequest extends Signal
	{
		public function HandleLobbyPlayerLeftRequest()
		{
			super( Message );
		}
	}
}