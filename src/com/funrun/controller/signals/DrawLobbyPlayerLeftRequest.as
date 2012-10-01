package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class DrawLobbyPlayerLeftRequest extends Signal
	{
		public function DrawLobbyPlayerLeftRequest()
		{
			super( String );
		}
	}
}