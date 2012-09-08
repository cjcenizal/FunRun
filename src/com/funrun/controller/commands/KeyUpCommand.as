package com.funrun.controller.commands {
	
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Player;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class KeyUpCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var event:KeyboardEvent;
		
		// Models.
		
		[Inject]
		public var keysModel:KeyboardModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		override public function execute():void {
			var key:uint = event.keyCode;
			keysModel.up( key );
			
			/*
			switch ( event.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					playerModel.isJumping = false;
					break;
				case Keyboard.DOWN:
					playerModel.isDucking = false;;
					break;
			}
			*/
			
			/*
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
			*/
		}
	}
}
