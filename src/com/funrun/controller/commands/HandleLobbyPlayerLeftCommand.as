package com.funrun.controller.commands
{
	import com.funrun.controller.signals.DrawLobbyPlayerLeftRequest;
	import com.funrun.controller.signals.vo.DrawLobbyPlayerLeftVo;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;
	
	public class HandleLobbyPlayerLeftCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Commands.
		
		[Inject]
		public var drawLobbyPlayerLeftRequest:DrawLobbyPlayerLeftRequest;
		
		override public function execute():void
		{
			drawLobbyPlayerLeftRequest.dispatch( new DrawLobbyPlayerLeftVo( message.getString( 0 ), message.getString( 1 ) ) );
		}
	}
}