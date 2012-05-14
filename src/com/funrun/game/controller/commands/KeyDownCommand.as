package com.funrun.game.controller.commands {
	
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.constants.TrackConstants;
	
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
					trace("jump: " + playerModel.isAirborne);
					if ( !playerModel.isAirborne ) {
						playerModel.jump( TrackConstants.PLAYER_JUMP_SPEED );
					}
					break;
				case Keyboard.LEFT:
					playerModel.startMovingLeft( TrackConstants.PLAYER_LATERAL_SPEED );
					break;
				case Keyboard.RIGHT:
					playerModel.startMovingRight( TrackConstants.PLAYER_LATERAL_SPEED );
					break;
				case Keyboard.DOWN:
					playerModel.startDucking();
					break;
			}	
		}
	}
}
