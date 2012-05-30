package com.funrun.controller.signals
{
	import com.cenizal.ui.AbstractLabel;
	
	import org.osflash.signals.Signal;
	
	public class AddNametagRequest extends Signal
	{
		public function AddNametagRequest()
		{
			super( AbstractLabel );
		}
	}
}