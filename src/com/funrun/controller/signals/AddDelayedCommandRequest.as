package com.funrun.controller.signals
{
	import com.funrun.controller.signals.vo.AddDelayedCommandVo;
	
	import org.osflash.signals.Signal;
	
	public class AddDelayedCommandRequest extends Signal
	{
		public function AddDelayedCommandRequest()
		{
			super( AddDelayedCommandVo );
		}
	}
}