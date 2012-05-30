package com.funrun.controller.signals
{
	import com.funrun.model.vo.PlayerioErrorVO;
	
	import org.osflash.signals.Signal;
	
	import playerio.PlayerIOError;
	
	public class ShowPlayerioErrorPopupRequest extends Signal
	{
		public function ShowPlayerioErrorPopupRequest()
		{
			super( PlayerioErrorVO );
		}
	}
}