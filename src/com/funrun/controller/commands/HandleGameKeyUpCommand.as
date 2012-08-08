package com.funrun.controller.commands {
	
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Player;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class HandleGameKeyUpCommand extends Command {
		
		[Inject]
		public var event:KeyboardEvent;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		override public function execute():void {
			switch ( event.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					playerModel.isJumping = false;
					break;
				case Keyboard.LEFT:
					playerModel.stopMovingLeft( Player.LATERAL_SPEED );
					break;
				case Keyboard.RIGHT:
					playerModel.stopMovingRight( Player.LATERAL_SPEED );
					break;
				case Keyboard.DOWN:
					playerModel.isDucking = false;;
					break;
			}
		}
	}
}
