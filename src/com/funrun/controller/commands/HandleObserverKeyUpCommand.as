package com.funrun.controller.commands {
	
	import com.funrun.model.ObserverModel;
	import com.funrun.model.CompetitorsModel;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class HandleObserverKeyUpCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var event:KeyboardEvent;
		
		// Models.
		
		[Inject]
		public var observerModel:ObserverModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		override public function execute():void {
			switch ( event.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					break;
				case Keyboard.LEFT:
					break;
				case Keyboard.RIGHT:
					break;
				case Keyboard.DOWN:
					
					break;
			}
		}
	}
}
