package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.SelectCharacterRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.PlayerProperties;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Command;

	public class CompleteAppCommand extends Command {
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var selectCharacterRequest:SelectCharacterRequest;
		
		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		override public function execute():void {
			// Build player.
			selectCharacterRequest.dispatch( playerModel.properties[ PlayerProperties.CHARACTER ] );
			
			// Enable main menu.
			enableMainMenuRequest.dispatch( true );
			
			// Respond to keyboard input.
			commandMap.mapEvent( KeyboardEvent.KEY_UP, KeyUpCommand, KeyboardEvent );
			commandMap.mapEvent( KeyboardEvent.KEY_DOWN, KeyDownCommand, KeyboardEvent );
			commandMap.mapEvent( MouseEvent.MOUSE_DOWN, MouseDownCommand, MouseEvent );
			commandMap.mapEvent( MouseEvent.MOUSE_UP, MouseUpCommand, MouseEvent );
			commandMap.mapEvent( MouseEvent.MOUSE_MOVE, MouseMoveCommand, MouseEvent );
			commandMap.mapEvent( MouseEvent.MOUSE_WHEEL, MouseWheelCommand, MouseEvent );
		}
	}
}
