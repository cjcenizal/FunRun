package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.View3DModel;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class StartObserverLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3DModel:View3DModel;
		
		// Temp.
		
		[Inject]
		public var removeFindingGamePopupRequest:RemoveFindingGamePopupRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function execute():void {
			// Set camera.
			view3DModel.cameraX = 1400;
			view3DModel.cameraY = 900;
			view3DModel.update();
			
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateObserverLoopCommand, TimeEvent );
			
			// Respond to keyboard input.
			commandMap.mapEvent( KeyboardEvent.KEY_UP, UpdateObserverKeyUpCommand, KeyboardEvent );
			commandMap.mapEvent( KeyboardEvent.KEY_DOWN, UpdateObserverKeyDownCommand, KeyboardEvent );
			
			// TEMP: Show game screen.
			removeFindingGamePopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
		}
	}
}
