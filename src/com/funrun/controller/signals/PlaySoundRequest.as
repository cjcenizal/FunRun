package com.funrun.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class PlaySoundRequest extends Signal
	{
		public function PlaySoundRequest()
		{
			super( String );
		}
	}
}