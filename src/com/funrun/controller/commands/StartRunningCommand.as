package com.funrun.controller.commands {

	import com.funrun.controller.signals.DrawGameMessageRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.DrawCountdownRequest;
	import com.funrun.model.StateModel;
	
	import org.robotlegs.mvcs.Command;

	public class StartRunningCommand extends Command {
		
		// Models.
		
		[Inject]
		public var stateModel:StateModel;
		
		// Commands.
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var updateCountdownRequest:DrawCountdownRequest;
		
		[Inject]
		public var displayMessageRequest:DrawGameMessageRequest;
		
		override public function execute():void {
			// Stop countdown.
			updateCountdownRequest.dispatch( "" );
			toggleCountdownRequest.dispatch( false );
			// Set game state.
			//stateModel.startRunning();
			displayMessageRequest.dispatch( "Go!" );
		}
	}
}
