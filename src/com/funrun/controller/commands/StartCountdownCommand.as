package com.funrun.controller.commands {

	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.model.CountdownModel;
	
	import org.robotlegs.mvcs.Command;

	public class StartCountdownCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var remainingSeconds:Number;
		
		// Models.
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		// Commands.
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		override public function execute():void {
			countdownModel.start( remainingSeconds * 1000 );
			toggleCountdownRequest.dispatch( true );
		}
	}
}
