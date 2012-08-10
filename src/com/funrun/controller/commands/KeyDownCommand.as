package com.funrun.controller.commands {
	
	import com.funrun.model.KeysModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Player;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class KeyDownCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var event:KeyboardEvent;
		
		// Models.
		
		[Inject]
		public var keysModel:KeysModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		override public function execute():void {
			var key:uint = event.keyCode;
			keysModel.down( key );
			
			/*
			switch ( event.keyCode ) {
				case Keyboard.SPACE:
				case Keyboard.UP:
					playerModel.isJumping = true;
					break;
				case Keyboard.LEFT:
					playerModel.startMovingLeft( Player.LATERAL_SPEED );
					break;
				case Keyboard.RIGHT:
					playerModel.startMovingRight( Player.LATERAL_SPEED );
					break;
				case Keyboard.DOWN:
					playerModel.isDucking = true;
					break;
			}
			*/
			
			/*
			switch ( event.keyCode ) {
				case Keyboard.SPACE:
					followNewCompetitorRequest.dispatch( 1 );
				case Keyboard.UP:
					followNewCompetitorRequest.dispatch( 1 );
					break;
				case Keyboard.LEFT:
					followNewCompetitorRequest.dispatch( -1 );
					break;
				case Keyboard.RIGHT:
					followNewCompetitorRequest.dispatch( 1 );
					break;
				case Keyboard.DOWN:
					followNewCompetitorRequest.dispatch( -1 );
					break;
			}
			*/
		}
	}
}
