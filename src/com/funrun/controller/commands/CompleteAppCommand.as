package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnableMainMenuRequest;
	
	import org.robotlegs.mvcs.Command;

	public class CompleteAppCommand extends Command {
		
		// Commands.
		
		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		override public function execute():void {
			enableMainMenuRequest.dispatch( true );
		}
	}
}
