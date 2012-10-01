package com.funrun.controller.signals
{
	import com.funrun.controller.signals.vo.DrawLobbyPlayerJoinedVo;
	
	import org.osflash.signals.Signal;
	
	public class DrawLobbyPlayerJoinedRequest extends Signal
	{
		public function DrawLobbyPlayerJoinedRequest()
		{
			super( DrawLobbyPlayerJoinedVo );
		}
	}
}