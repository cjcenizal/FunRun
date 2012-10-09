package com.funrun.controller.commands {

	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.ToggleReadyButtonRequest;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.constants.Time;
	
	import flash.utils.setTimeout;
	
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
				setTimeout( function():void {
					countdownModel.start( Time.COUNTDOWN_SECONDS * 1000 );
					toggleCountdownRequest.dispatch( true );
				}, Time.COUNTDOWN_WAIT_SECONDS * 1000 );
			} else {
				countdownModel.start( Time.COUNTDOWN_SECONDS * 1000 );
			}
			toggleReadyButtonRequest.dispatch( false );
		}
	}
}
