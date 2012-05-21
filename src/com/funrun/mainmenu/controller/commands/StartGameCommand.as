package com.funrun.mainmenu.controller.commands {
	
	import com.funrun.mainmenu.controller.events.StopRunningMainMenuRequest;
	
	import org.robotlegs.mvcs.Command;

	public class StartGameCommand extends Command {
		
		override public function execute():void {
			// Stop the main menu.
			eventDispatcher.dispatchEvent( new StopRunningMainMenuRequest( StopRunningMainMenuRequest.STOP_RUNNING_MAIN_MENU_REQUESTED ) );
		}
	}
}
