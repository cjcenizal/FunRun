package com.funrun.game.controller.commands {

	import com.funrun.game.controller.signals.payloads.ToggleMainMenuOptionsPayload;
	
	import org.robotlegs.mvcs.Command;

	public class ToggleMainMenuCommand extends Command {
		
		[Inject]
		public var payload:ToggleMainMenuOptionsPayload;
		
		//[Inject]
		//public var moduleDispatcher:IModuleEventDispatcher;
		
		override public function execute():void {
			//moduleDispatcher.dispatchEvent( new ExternalToggleMainMenuOptionsRequest( ExternalToggleMainMenuOptionsRequest.EXTERNAL_TOGGLE_MAIN_MENU_OPTIONS_REQUESTED, payload ) );
		}
	}
}
