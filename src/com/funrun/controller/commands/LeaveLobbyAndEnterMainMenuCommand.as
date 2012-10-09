
package com.funrun.controller.commands
{
	import com.funrun.controller.signals.JoinMainMenuRequest;
	import com.funrun.services.LobbyService;
	
	import org.robotlegs.mvcs.Command;
	
	public class LeaveLobbyAndEnterMainMenuCommand extends Command
	{
		
		// Services.
		
		[Inject]
		public var lobbyService:LobbyService;
		
		// Commands.
		
		[Inject]
		public var joinMainMenuRequest:JoinMainMenuRequest;
		
		override public function execute():void {
			// Disconnect from lobby.
			lobbyService.disconnectAndReset();
			joinMainMenuRequest.dispatch();
		}
	}
}