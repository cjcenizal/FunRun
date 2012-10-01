package com.funrun.controller.commands
{
	import com.funrun.controller.signals.DrawLobbyPlayerLeftRequest;
	
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
			drawLobbyPlayerLeftRequest.dispatch( message.getString( 0 ) );
		}
	}
}