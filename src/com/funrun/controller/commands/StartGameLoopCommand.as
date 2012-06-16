package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;

	public class StartGameLoopCommand extends Command {
		
		// Commands.
		
		[Inject]
		public var startGameLoopRequest:StartGameLoopRequest;
		
		[Inject]
		public var removeFindingGamePopupRequest:RemoveFindingGamePopupRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		
		override public function execute():void {
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			
			// Respond to keyboard input.
			commandMap.mapEvent( KeyboardEvent.KEY_UP, UpdateGameKeyUpCommand, KeyboardEvent );
			commandMap.mapEvent( KeyboardEvent.KEY_DOWN, UpdateGameKeyDownCommand, KeyboardEvent );
			
			// Show game screen.
			removeFindingGamePopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
		}
	}
}
