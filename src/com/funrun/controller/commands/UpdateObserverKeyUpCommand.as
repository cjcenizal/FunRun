package com.funrun.controller.commands {
	
	import com.funrun.model.ObserverModel;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateObserverKeyUpCommand extends Command {
		
		[Inject]
		public var event:KeyboardEvent;
		
		[Inject]
		public var observationModel:ObserverModel;
		
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
