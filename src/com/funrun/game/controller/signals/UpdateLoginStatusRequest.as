package com.funrun.game.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class UpdateLoginStatusRequest extends Signal
	{
		public function UpdateLoginStatusRequest()
		{
			super( String );
		}
	}
}