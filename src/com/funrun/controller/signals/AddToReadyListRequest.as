package com.funrun.controller.signals
{
	import com.funrun.controller.signals.vo.AddToReadyListVo;
	
	import org.osflash.signals.Signal;
	
	public class AddToReadyListRequest extends Signal
	{
		public function AddToReadyListRequest()
		{
			super( AddToReadyListVo );
		}
	}
}