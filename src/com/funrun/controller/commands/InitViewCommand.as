package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.JoinMainMenuRequest;
	import com.funrun.controller.signals.ShowLoadingRequest;
	
	import org.robotlegs.mvcs.Command;

	public class InitViewCommand extends Command {
		
		// Commands.
		
		[Inject]
		public var joinMainMenuRequest:JoinMainMenuRequest;
		
		[Inject]
		public var showLoadingRequest:ShowLoadingRequest;
		
		override public function execute():void {
			// Show main menu, but disable it.
			joinMainMenuRequest.dispatch();
			showLoadingRequest.dispatch( "Sup, player!" );
		}
	}
}
