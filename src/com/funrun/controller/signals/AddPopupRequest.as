package com.funrun.controller.signals
{
	import com.funrun.view.components.Popup;
	
	import org.osflash.signals.Signal;
	
	public class AddPopupRequest extends Signal
	{
		public function AddPopupRequest()
		{
			super( Popup );
		}
	}
}