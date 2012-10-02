package com.funrun.controller.commands
{
	import com.funrun.controller.signals.DrawLobbyPlayerJoinedRequest;
	import com.funrun.controller.signals.vo.DrawLobbyPlayerJoinedVo;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;
	
	public class HandleLobbyWelcomeCommand extends Command
	{
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Commands.
		
		[Inject]
		public var drawLobbyPlayerJoinedRequest:DrawLobbyPlayerJoinedRequest;
		
		override public function execute():void
		{
			for ( var i:int = 0; i < message.length; i += 2 ) {
				drawLobbyPlayerJoinedRequest.dispatch( new DrawLobbyPlayerJoinedVo( message.getString( i ), message.getString( i + 1 ) ) );
			}
		}
	}
}