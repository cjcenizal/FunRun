package com.funrun.controller.signals
{
	import com.funrun.controller.signals.vo.ShakeCameraVo;
	
	import org.osflash.signals.Signal;
	
	public class ShakeCameraRequest extends Signal
	{
		public function ShakeCameraRequest()
		{
			super( ShakeCameraVo );
		}
	}
}