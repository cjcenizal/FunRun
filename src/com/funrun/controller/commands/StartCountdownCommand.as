package com.funrun.controller.commands {

	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.ToggleReadyButtonRequest;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.constants.Time;
	
	import org.robotlegs.mvcs.Command;

	public class StartCountdownCommand extends Command {
		
		// Models.
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		// Commands.
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var toggleReadyButtonRequest:ToggleReadyButtonRequest;
		
		override public function execute():void {
			if ( gameModel.isMultiplayer ) {
				countdownModel.delayedStart( Time.COUNTDOWN_WAIT_SECONDS, function():void {
					toggleCountdownRequest.dispatch( true );
					countdownModel.start( Time.COUNTDOWN_SECONDS );
				} );
			} else {
				toggleCountdownRequest.dispatch( true );
				countdownModel.start( Time.COUNTDOWN_SECONDS );
			}
			toggleReadyButtonRequest.dispatch( false );
		}
	}
}
