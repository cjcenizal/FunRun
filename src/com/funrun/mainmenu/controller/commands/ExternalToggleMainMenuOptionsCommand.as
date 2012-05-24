package com.funrun.mainmenu.controller.commands {

	import com.funrun.game.controller.signals.DisableMainMenuOptionsRequest;
	import com.funrun.game.controller.signals.EnableMainMenuOptionsRequest;
	import com.funrun.modulemanager.controller.events.ExternalToggleMainMenuOptionsRequest;
	
	import org.robotlegs.mvcs.Command;

	public class ExternalToggleMainMenuOptionsCommand extends Command {

		[Inject]
		public var event:ExternalToggleMainMenuOptionsRequest;
		
		[Inject]
		public var enableMainMenuOptionsRequest:EnableMainMenuOptionsRequest;
		
		[Inject]
		public var disableMainMenuOptionsRequest:DisableMainMenuOptionsRequest;
		
		override public function execute():void {
			if ( event.payload.enabled ) {
				enableMainMenuOptionsRequest.dispatch();
			} else {
				disableMainMenuOptionsRequest.dispatch();
			}
		}
	}
}
