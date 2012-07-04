package com.funrun.controller.commands {

	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.InitGameRequest;
	import com.funrun.controller.signals.InitUserRequest;
	import com.funrun.controller.signals.InitViewRequest;
	
	import org.robotlegs.mvcs.Command;

	public class InitAppCommand extends Command {
		
		// Commands.
		
		[Inject]
		public var initAppViewRequest:InitViewRequest;
		
		[Inject]
		public var initUserReqest:InitUserRequest;
		
		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		[Inject]
		public var initGameRequest:InitGameRequest;
		
		override public function execute():void {
			// Show the user something while initializing the app.
			initAppViewRequest.dispatch();
			// Start the login process, and getting user account data.
			initUserReqest.dispatch();
			// Build everyhing that the game needs.
			initGameRequest.dispatch();
		}
	}
}
