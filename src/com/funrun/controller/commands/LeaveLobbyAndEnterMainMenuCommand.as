
package com.funrun.controller.commands
{
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.constants.Screen;
	import com.funrun.services.LobbyService;
	
	import org.robotlegs.mvcs.Command;
	
	public class LeaveLobbyAndEnterMainMenuCommand extends Command
	{
		
		// Services.
		
		[Inject]
		public var lobbyService:LobbyService;
		
		// Commands.
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function execute():void {
			// Disconnect from lobby.
			lobbyService.disconnectAndReset();
			// Show main menu.
			showScreenRequest.dispatch( Screen.MAIN_MENU );
		}
	}
}