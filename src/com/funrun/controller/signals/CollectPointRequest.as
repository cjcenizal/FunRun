package com.funrun.controller.signals
{
	import com.funrun.model.vo.CollectPointVo;
	
	import org.osflash.signals.Signal;
	
	public class CollectPointRequest extends Signal
	{
		public function CollectPointRequest()
		{
			super( CollectPointVo );
		}
	}
}