package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.constants.Screen;
	
	import org.robotlegs.mvcs.Command;

	public class InitViewCommand extends Command {
		
		// Commands.
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		[Inject]
		public var toggleMainModuleRequest:EnableMainMenuRequest;
		
		override public function execute():void {
			// Show main menu, but disable it.
			showScreenRequest.dispatch( Screen.MAIN_MENU );
			toggleMainModuleRequest.dispatch( false );
		}
	}
}
