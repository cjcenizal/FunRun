package com.funrun.controller.signals
{
	import com.funrun.controller.signals.vo.UpdateTrackVo;
	
	import org.osflash.signals.Signal;
	
	public class UpdateTrackRequest extends Signal
	{
		public function UpdateTrackRequest()
		{
			super( UpdateTrackVo );
		}
	}
}