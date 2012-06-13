package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.model.TrackModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;

	public class StartGameLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3DModel:View3DModel;
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var startGameLoopRequest:StartGameLoopRequest;
		
		[Inject]
		public var removeFindingGamePopupRequest:RemoveFindingGamePopupRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		
		override public function execute():void {
			// Set camera.
			view3DModel.cameraX = 0;
			view3DModel.cameraY = 100;
			view3DModel.update();
			
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			
			// Respond to keyboard input.
			commandMap.mapEvent( KeyboardEvent.KEY_UP, UpdateGameKeyUpCommand, KeyboardEvent );
			commandMap.mapEvent( KeyboardEvent.KEY_DOWN, UpdateGameKeyDownCommand, KeyboardEvent );
			
			// Show game screen.
			removeFindingGamePopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
		}
	}
}
