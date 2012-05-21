package com.funrun.mainmenu.controller.commands {
	
	import com.funrun.mainmenu.controller.events.StartRunningMainMenuRequest;
	
	import org.robotlegs.mvcs.Command;

	public class ExternalShowMainMenuCommand extends Command {
		
		override public function execute():void {
			eventDispatcher.dispatchEvent( new StartRunningMainMenuRequest( StartRunningMainMenuRequest.START_RUNNING_MAIN_MENU_REQUESTED ) );
		}
	}
}
