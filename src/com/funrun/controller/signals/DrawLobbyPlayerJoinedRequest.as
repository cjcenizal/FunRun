package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class DrawLobbyPlayerJoinedRequest extends Signal
	{
		public function DrawLobbyPlayerJoinedRequest()
		{
			super( String );
		}
	}
}