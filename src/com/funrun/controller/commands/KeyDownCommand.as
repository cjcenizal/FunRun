package com.funrun.controller.commands {
	
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.TrackConstants;
	
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
					playerModel.isJumping = true;
					break;
				case Keyboard.LEFT:
					playerModel.startMovingLeft( TrackConstants.PLAYER_LATERAL_SPEED );
					break;
				case Keyboard.RIGHT:
					playerModel.startMovingRight( TrackConstants.PLAYER_LATERAL_SPEED );
					break;
				case Keyboard.DOWN:
					playerModel.isDucking = true;
					break;
			}	
		}
	}
}
