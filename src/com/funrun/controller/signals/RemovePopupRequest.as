package com.funrun.controller.signals
{
	import com.funrun.view.components.Popup;
	
	import org.osflash.signals.Signal;
	
	public class RemovePopupRequest extends Signal
	{
		public function RemovePopupRequest()
		{
			super( Popup );
		}
	}
}