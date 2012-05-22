package com.funrun.mainmenu.controller.commands {

	import com.funrun.mainmenu.controller.events.ToggleMainMenuOptionsRequest;
	import com.funrun.modulemanager.controller.events.ExternalToggleMainMenuOptionsRequest;
	
	import org.robotlegs.mvcs.Command;

	public class ExternalToggleMainMenuOptionsCommand extends Command {

		[Inject]
		public var event:ExternalToggleMainMenuOptionsRequest;
		
		override public function execute():void {
			eventDispatcher.dispatchEvent( new ToggleMainMenuOptionsRequest( ToggleMainMenuOptionsRequest.TOGGLE_MAIN_MENU_OPTIONS_REQUESTED, event.enabled ) );
		}
	}
}
