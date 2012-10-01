package com.funrun.controller.commands
{
	import com.funrun.controller.signals.DrawLobbyChatRequest;
	import com.funrun.controller.signals.vo.DrawLobbyChatVo;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;
	
	public class HandleLobbyChatCommand extends Command
	{
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Commands.
		
		[Inject]
		public var drawLobbyChatRequest:DrawLobbyChatRequest;
		
		override public function execute():void
		{
			drawLobbyChatRequest.dispatch( new DrawLobbyChatVo( message.getString( 0 ), message.getString( 1 ) ) );
		}
	}
}