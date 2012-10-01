package com.funrun.controller.commands
{
	import com.funrun.controller.signals.DrawLobbyPlayerJoinedRequest;
	import com.funrun.controller.signals.vo.DrawLobbyPlayerJoinedVo;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;
	
	public class HandleLobbyPlayerJoinedCommand extends Command
	{
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Commands.
		
		[Inject]
		public var drawLobbyPlayerJoinedRequest:DrawLobbyPlayerJoinedRequest;
		
		override public function execute():void
		{
			drawLobbyPlayerJoinedRequest.dispatch( new DrawLobbyPlayerJoinedVo( message.getString( 0 ), message.getString( 1 ) ) );
		}
	}
}