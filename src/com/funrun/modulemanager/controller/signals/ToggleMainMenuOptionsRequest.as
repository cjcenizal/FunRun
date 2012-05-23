package com.funrun.modulemanager.controller.signals
{
	import com.funrun.modulemanager.controller.signals.payloads.ToggleMainMenuOptionsPayload;
	
	import org.osflash.signals.Signal;
	
	public class ToggleMainMenuOptionsRequest extends Signal
	{
		public function ToggleMainMenuOptionsRequest()
		{
			super( ToggleMainMenuOptionsPayload );
		}
	}
}