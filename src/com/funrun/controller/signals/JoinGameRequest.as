package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class JoinGameRequest extends Signal
	{
		public function JoinGameRequest()
		{
			super( String );
		}
	}
}