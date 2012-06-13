package com.funrun.controller.commands {
	
	import com.funrun.model.events.TimeEvent;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class StopGameLoopCommand extends Command {
		
		override public function execute():void {
			commandMap.unmapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			commandMap.unmapEvent( KeyboardEvent.KEY_UP, UpdateGameKeyUpCommand, KeyboardEvent );
			commandMap.unmapEvent( KeyboardEvent.KEY_DOWN, UpdateGameKeyDownCommand, KeyboardEvent );
		}
	}
}
