package com.funrun.mainmenu.controller.commands {
	
	import com.funrun.mainmenu.controller.signals.StartRunningMainMenuRequest;
	
	import org.robotlegs.mvcs.Command;

	public class ExternalShowMainMenuCommand extends Command {
		
		[Inject]
		public var startRunningMainMenuRequest:StartRunningMainMenuRequest;
		
		override public function execute():void {
			startRunningMainMenuRequest.dispatch();
		}
	}
}
