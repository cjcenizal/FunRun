package com.funrun.controller.signals
{
	import com.funrun.controller.signals.vo.LogMessageVo;
	
	import org.osflash.signals.Signal;
	
	public class LogMessageRequest extends Signal
	{
		public function LogMessageRequest()
		{
			super( LogMessageVo );
		}
	}
}