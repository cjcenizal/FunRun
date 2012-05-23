package com.funrun.modulemanager.controller.commands {

	import com.funrun.modulemanager.controller.events.ExternalToggleMainMenuOptionsRequest;
	import com.funrun.modulemanager.controller.signals.payloads.ToggleMainMenuOptionsRequestPayload;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.modular.core.IModuleEventDispatcher;

	public class ToggleMainMenuCommand extends Command {
		
		[Inject]
		public var payload:ToggleMainMenuOptionsRequestPayload;
		
		[Inject]
		public var moduleDispatcher:IModuleEventDispatcher;
		
		override public function execute():void {
			moduleDispatcher.dispatchEvent( new ExternalToggleMainMenuOptionsRequest( ExternalToggleMainMenuOptionsRequest.EXTERNAL_TOGGLE_MAIN_MENU_OPTIONS_REQUESTED, payload ) );
		}
	}
}
