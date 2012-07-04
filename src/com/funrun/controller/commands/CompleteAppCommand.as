package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.model.state.LoginState;;
	import com.funrun.model.state.AssetLoadingState;
	import org.robotlegs.mvcs.Command;

	public class CompleteAppCommand extends Command {
		
		// Commands.
		
		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		override public function execute():void {
			if ( LoginState.isComplete
				&& AssetLoadingState.isComplete ) {
				enableMainMenuRequest.dispatch( true );
			}
		}
	}
}
