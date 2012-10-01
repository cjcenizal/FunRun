package com.funrun.controller.signals
{
	import com.funrun.controller.signals.vo.DrawLobbyPlayerLeftVo;
	
	import org.osflash.signals.Signal;
	
	public class DrawLobbyPlayerLeftRequest extends Signal
	{
		public function DrawLobbyPlayerLeftRequest()
		{
			super( DrawLobbyPlayerLeftVo );
		}
	}
}