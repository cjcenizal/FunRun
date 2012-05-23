package com.funrun.modulemanager.controller.commands {
	
	import com.funrun.modulemanager.controller.signals.ToggleMainMenuOptionsRequest;
	import com.funrun.modulemanager.controller.signals.payloads.ToggleMainMenuOptionsPayload;
	
	import org.robotlegs.mvcs.Command;

	public class LoginFulfilledCommand extends Command {
		
		[Inject]
		public var toggleMainModuleRequest:ToggleMainMenuOptionsRequest;
		
		override public function execute():void {
			toggleMainModuleRequest.dispatch( new ToggleMainMenuOptionsPayload( true ) );
		}
	}
}
