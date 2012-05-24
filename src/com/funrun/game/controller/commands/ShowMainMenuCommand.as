package com.funrun.game.controller.commands {

	import org.robotlegs.mvcs.Command;

	public class ShowMainMenuCommand extends Command {
		
		//[Inject]
		//public var moduleDispatcher:IModuleEventDispatcher;
		
		override public function execute():void {
			//moduleDispatcher.dispatchEvent( new ExternalShowMainMenuModuleRequest( ExternalShowMainMenuModuleRequest.EXTERNAL_SHOW_MAIN_MENU_MODULE_REQUESTED ) );
		}
	}
}
