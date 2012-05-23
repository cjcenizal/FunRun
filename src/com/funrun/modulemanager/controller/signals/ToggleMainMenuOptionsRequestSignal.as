package com.funrun.modulemanager.controller.signals
{
	import com.funrun.modulemanager.controller.signals.payloads.ToggleMainMenuOptionsRequestPayload;
	
	import org.osflash.signals.Signal;
	
	public class ToggleMainMenuOptionsRequestSignal extends Signal
	{
		public function ToggleMainMenuOptionsRequestSignal()
		{
			super( ToggleMainMenuOptionsRequestPayload );
		}
	}
}