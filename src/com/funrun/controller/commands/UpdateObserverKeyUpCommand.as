package com.funrun.controller.commands {
	
	import com.funrun.model.ObservationModel;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateObserverKeyUpCommand extends Command {
		
		[Inject]
		public var event:KeyboardEvent;
		
		[Inject]
		public var observationModel:ObservationModel;
		
		override public function execute():void {
			switch ( event.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					
					break;
				case Keyboard.LEFT:
					observationModel.direction = 0;
					break;
				case Keyboard.RIGHT:
					observationModel.direction = 0;
					break;
				case Keyboard.DOWN:
					
					break;
			}
		}
	}
}
