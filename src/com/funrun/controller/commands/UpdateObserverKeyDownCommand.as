package com.funrun.controller.commands {
	
	import com.funrun.model.ObserverModel;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateObserverKeyDownCommand extends Command {
		
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
					observationModel.direction = -1;
					break;
				case Keyboard.RIGHT:
					observationModel.direction = 1;
					break;
				case Keyboard.DOWN:
					
					break;
			}
		}
	}
}
