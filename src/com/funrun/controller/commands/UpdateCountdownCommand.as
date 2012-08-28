package com.funrun.controller.commands
{
	import com.funrun.controller.signals.DrawCountdownRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.model.CountdownModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateCountdownCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		// Commands.
		
		[Inject]
		public var drawCountdownRequest:DrawCountdownRequest;
		
		[Inject]
		public var startRunningRequest:StartRunningRequest;
		
		override public function execute():void {
			if ( countdownModel.isRunning ) {
				if ( countdownModel.secondsRemaining > 0 ) {
					// Continue the countdown.
					drawCountdownRequest.dispatch( countdownModel.secondsRemaining.toString() );
				} else {
					// Start running.
					startRunningRequest.dispatch();
				}
			}
		}
	}
}