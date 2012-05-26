package com.funrun.controller.commands {

	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.UpdateCountdownRequest;
	import com.funrun.model.GameModel;
	import com.funrun.model.state.GameState;
	
	import org.robotlegs.mvcs.Command;

	public class StartRunningCommand extends Command {
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var updateCountdownRequest:UpdateCountdownRequest;
		
		override public function execute():void {
			// Stop countdown.
			updateCountdownRequest.dispatch( "" );
			toggleCountdownRequest.dispatch( false );
			// Set game state.
			gameModel.gameState = GameState.RUNNING;
		}
	}
}
