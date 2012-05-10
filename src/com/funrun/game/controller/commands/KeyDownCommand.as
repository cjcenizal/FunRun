package com.funrun.game.controller.commands {
	
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.Constants;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class KeyDownCommand extends Command {
		
		[Inject]
		public var event:KeyboardEvent;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		override public function execute():void {
			switch ( event.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					if ( !playerModel.isAirborne ) {
						playerModel.jump( Constants.PLAYER_JUMP_SPEED );
					}
					break;
				case Keyboard.LEFT:
					playerModel.startMovingLeft( Constants.PLAYER_LATERAL_SPEED );
					break;
				case Keyboard.RIGHT:
					playerModel.startMovingRight( Constants.PLAYER_LATERAL_SPEED );
					break;
				case Keyboard.DOWN:
					playerModel.startDucking();
					break;
			}	
		}
	}
}
