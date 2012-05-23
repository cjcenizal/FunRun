package com.funrun.game.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class UpdateCountdownRequest extends Signal
	{
		public function UpdateCountdownRequest()
		{
			super( String );
		}
	}
}