package com.funrun.controller.commands {
	
	import com.funrun.model.events.TimeEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class StopObserverLoopCommand extends Command {
		
		override public function execute():void {
			commandMap.unmapEvent( TimeEvent.TICK, UpdateObserverLoopCommand, TimeEvent );
		}
	}
}
