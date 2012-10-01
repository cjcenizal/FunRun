package com.funrun.controller.signals
{
	import com.funrun.controller.signals.vo.AddSegmentVo;
	
	import org.osflash.signals.Signal;
	
	public class AddSegmentRequest extends Signal
	{
		public function AddSegmentRequest()
		{
			super( AddSegmentVo );
		}
	}
}