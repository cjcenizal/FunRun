package com.funrun.controller.commands {

	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;

	import org.robotlegs.mvcs.Command;

	public class InitGameCommand extends Command {

		// Commands.

		[Inject]
		public var enablePlayerInputRequest:EnablePlayerInputRequest;

		[Inject]
		public var removeFindingGamePopupRequest:RemoveFindingGamePopupRequest;

		[Inject]
		public var showScreenRequest:ShowScreenRequest;

		override public function execute():void {
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			// Start input.
			enablePlayerInputRequest.dispatch( true );
			// Show game screen.
			removeFindingGamePopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
		}
	}
}