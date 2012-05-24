package com.funrun.game.controller.signals
{
	import com.funrun.game.controller.signals.payloads.ToggleMainMenuOptionsPayload;
	
	import org.osflash.signals.Signal;
	
	public class ToggleMainMenuOptionsRequest extends Signal
	{
		public function ToggleMainMenuOptionsRequest()
		{
			super( ToggleMainMenuOptionsPayload );
		}
	}
}