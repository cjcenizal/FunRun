package com.funrun.controller.commands {

	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.model.CountdownMockModel;
	
	import org.robotlegs.mvcs.Command;

	public class StartCountdownCommand extends Command {
		
		// Arguments.
		
		public var remainingMs:Number;
		
		// Models.
		
		public var countdownModel:CountdownMockModel;
		
		// Commands.
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		override public function execute():void {
			//countdownModel.secondsRemaining = Math.ceil( remainingMs / 1000 );
			toggleCountdownRequest.dispatch( true );
		}
	}
}
