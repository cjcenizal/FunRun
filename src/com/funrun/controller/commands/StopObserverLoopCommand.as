package com.funrun.controller.commands {
	
	import com.funrun.model.events.TimeEvent;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class StopObserverLoopCommand extends Command {
		
		override public function execute():void {
			commandMap.unmapEvent( TimeEvent.TICK, UpdateObserverLoopCommand, TimeEvent );
			commandMap.unmapEvent( KeyboardEvent.KEY_UP, HandleObserverKeyUpCommand, KeyboardEvent );
			commandMap.unmapEvent( KeyboardEvent.KEY_DOWN, HandleObserverKeyDownCommand, KeyboardEvent );
		}
	}
}
