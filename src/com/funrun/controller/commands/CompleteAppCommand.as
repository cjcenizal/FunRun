package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnableMainMenuRequest;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;

	public class CompleteAppCommand extends Command {
		
		// Commands.
		
		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		override public function execute():void {
			enableMainMenuRequest.dispatch( true );
			
			// Respond to keyboard input.
			commandMap.mapEvent( KeyboardEvent.KEY_UP, KeyUpCommand, KeyboardEvent );
			commandMap.mapEvent( KeyboardEvent.KEY_DOWN, KeyDownCommand, KeyboardEvent );
		}
	}
}
