package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.JoinMainMenuRequest;
	
	import org.robotlegs.mvcs.Command;

	public class InitViewCommand extends Command {
		
		// Commands.
		
		[Inject]
		public var joinMainMenuRequest:JoinMainMenuRequest;
		
		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		override public function execute():void {
			// Show main menu, but disable it.
			joinMainMenuRequest.dispatch();
			enableMainMenuRequest.dispatch( false );
		}
	}
}
