package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	import playerio.Message;
	
	public class HandleLobbyPlayerJoinedRequest extends Signal
	{
		public function HandleLobbyPlayerJoinedRequest()
		{
			super( Message );
		}
	}
}