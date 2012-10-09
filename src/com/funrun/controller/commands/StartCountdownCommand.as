package com.funrun.controller.commands {

	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.model.CountdownModel;
	
	import org.robotlegs.mvcs.Command;

	public class StartCountdownCommand extends Command {
		
		// Models.
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		// Commands.
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		override public function execute():void {
			var countdownSeconds:int = 5;
			countdownModel.start( countdownSeconds * 1000 );
			toggleCountdownRequest.dispatch( true );
		}
	}
}
