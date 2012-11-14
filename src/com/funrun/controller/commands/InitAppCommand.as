package com.funrun.controller.commands {

	import com.funrun.controller.signals.CompleteAppRequest;
	
	import org.robotlegs.utilities.macrobot.ParallelCommand;

	public class InitAppCommand extends ParallelCommand {
		
		// Commands.
		
		[Inject]
		public var completeAppRequest:CompleteAppRequest;
		
		public function InitAppCommand() {
			// Show the user something while initializing the app.
			addCommand( InitViewCommand );
			// Start the login process, and getting user account data.
			addCommand( LoginPlayerCommand );
			// Build everyhing that the game needs.
			addCommand( InitGameCommand );
		}
		
		override protected function dispatchComplete(success:Boolean):void {
			super.dispatchComplete( success );
			completeAppRequest.dispatch();
		}
	}
}
