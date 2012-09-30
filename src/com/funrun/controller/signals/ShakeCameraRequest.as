package com.funrun.controller.signals
{
	import com.funrun.model.vo.ShakeCameraVo;
	
	import org.osflash.signals.Signal;
	
	public class ShakeCameraRequest extends Signal
	{
		public function ShakeCameraRequest()
		{
			super( ShakeCameraVo );
		}
	}
}