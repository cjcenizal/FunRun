package com.funrun.modulemanager.controller.commands {

	import com.funrun.modulemanager.controller.events.ExternalShowMainMenuModuleRequest;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.modular.core.IModuleEventDispatcher;

	public class ShowMainMenuCommand extends Command {
		
		[Inject]
		public var moduleDispatcher:IModuleEventDispatcher;
		
		override public function execute():void {
			moduleDispatcher.dispatchEvent( new ExternalShowMainMenuModuleRequest( ExternalShowMainMenuModuleRequest.EXTERNAL_SHOW_MAIN_MENU_MODULE_REQUESTED ) );
		}
	}
}
