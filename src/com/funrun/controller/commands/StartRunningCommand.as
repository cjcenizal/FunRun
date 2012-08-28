package com.funrun.controller.commands {

	import com.funrun.controller.signals.DrawMessageRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.DrawCountdownRequest;
	import com.funrun.model.state.GameState;
	
	import org.robotlegs.mvcs.Command;

	public class StartRunningCommand extends Command {
		
		// State.
		
		[Inject]
		public var gameState:GameState;
		
		// Commands.
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var updateCountdownRequest:DrawCountdownRequest;
		
		[Inject]
		public var displayMessageRequest:DrawMessageRequest;
		
		override public function execute():void {
			// Stop countdown.
			updateCountdownRequest.dispatch( "" );
			toggleCountdownRequest.dispatch( false );
			// Set game state.
			gameState.gameState = GameState.RUNNING;
			displayMessageRequest.dispatch( "Go!" );
		}
	}
}
