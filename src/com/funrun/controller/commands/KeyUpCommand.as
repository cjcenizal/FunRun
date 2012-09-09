package com.funrun.controller.commands {
	
	import com.funrun.model.KeyboardModel;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class KeyUpCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var event:KeyboardEvent;
		
		// Models.
		
		[Inject]
		public var keyboardModel:KeyboardModel;
		
		override public function execute():void {
			var key:uint = event.keyCode;
			keyboardModel.up( key );
		}
	}
}
