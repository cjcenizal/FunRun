package com.funrun.controller.commands {

	import com.funrun.controller.signals.DisplayMessageRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.UpdateCountdownRequest;
	import com.funrun.model.GameModel;
	import com.funrun.model.state.GameState;
	
	import org.robotlegs.mvcs.Command;

	public class StartRunningCommand extends Command {
		
		// Models.
		
		[Inject]
		public var gameModel:GameModel;
		
		// Commands.
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var updateCountdownRequest:UpdateCountdownRequest;
		
		[Inject]
		public var displayMessageRequest:DisplayMessageRequest;
		
		override public function execute():void {
			// Stop countdown.
			updateCountdownRequest.dispatch( "" );
			toggleCountdownRequest.dispatch( false );
			// Set game state.
			gameModel.gameState = GameState.RUNNING;
			displayMessageRequest.dispatch( "Go!" );
		}
	}
}
