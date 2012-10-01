package com.funrun.controller.signals
{
	import com.funrun.controller.signals.vo.PlayerioErrorVo;
	
	import org.osflash.signals.Signal;
	
	import playerio.PlayerIOError;
	
	public class ShowPlayerioErrorPopupRequest extends Signal
	{
		public function ShowPlayerioErrorPopupRequest()
		{
			super( PlayerioErrorVo );
		}
	}
}