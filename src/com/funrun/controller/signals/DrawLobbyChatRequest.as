package com.funrun.controller.signals
{
	import com.funrun.controller.signals.vo.DrawLobbyChatVo;
	
	import org.osflash.signals.Signal;
	
	public class DrawLobbyChatRequest extends Signal
	{
		public function DrawLobbyChatRequest()
		{
			super( DrawLobbyChatVo );
		}
	}
}