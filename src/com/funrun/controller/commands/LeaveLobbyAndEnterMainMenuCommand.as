
package com.funrun.controller.commands
{
	import com.funrun.controller.signals.EnterMainMenuRequest;
	import com.funrun.services.LobbyService;
	
	import org.robotlegs.mvcs.Command;
	
	public class LeaveLobbyAndEnterMainMenuCommand extends Command
	{
		
		// Services.
		
		[Inject]
		public var lobbyService:LobbyService;
		
		// Commands.
		
		[Inject]
		public var enterMainMenuRequest:EnterMainMenuRequest;
		
		override public function execute():void {
			// Disconnect from lobby.
			lobbyService.disconnectAndReset();
			enterMainMenuRequest.dispatch();
		}
	}
}