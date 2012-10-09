package com.funrun.controller.commands {

	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.model.CountdownModel;
	import flash.utils.setTimeout;
	import com.funrun.model.constants.Time;
	
	import org.robotlegs.mvcs.Command;

	public class StartCountdownCommand extends Command {
		
		// Models.
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		// Commands.
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		override public function execute():void {
			setTimeout( function():void {
				countdownModel.start( Time.COUNTDOWN_SECONDS * 1000 );
				toggleCountdownRequest.dispatch( true );
			}, Time.COUNTDOWN_WAIT_SECONDS * 1000 );
		}
	}
}
