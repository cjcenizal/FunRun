package com.funrun.mainmenu.controller.commands {
	
	
	import com.funrun.game.controller.signals.StopRunningMainMenuRequest;
	
	import org.robotlegs.mvcs.Command;

	public class ExternalShowGameModuleCommand extends Command {
		
		[Inject]
		public var stopRunningMainMenuRequest:StopRunningMainMenuRequest;
		
		override public function execute():void {
			stopRunningMainMenuRequest.dispatch();
		}
	}
}
