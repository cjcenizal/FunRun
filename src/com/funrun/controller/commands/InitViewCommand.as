package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnterMainMenuRequest;
	import com.funrun.controller.signals.ShowLoadingRequest;
	
	import org.robotlegs.mvcs.Command;

	public class InitViewCommand extends Command {
		
		// Commands.
		
		[Inject]
		public var enterMainMenuRequest:EnterMainMenuRequest;
		
		[Inject]
		public var showLoadingRequest:ShowLoadingRequest;
		
		override public function execute():void {
			// Show main menu, but disable it.
			enterMainMenuRequest.dispatch();
			showLoadingRequest.dispatch( "Sup, player!" );
		}
	}
}
