package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.model.TrackModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;
	
	import org.robotlegs.mvcs.Command;

	public class StartGameLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var cameraModel:View3DModel;
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var startGameLoopRequest:StartGameLoopRequest;
		
		[Inject]
		public var enablePlayerInputRequest:EnablePlayerInputRequest;
		
		[Inject]
		public var removeFindingGamePopupRequest:RemoveFindingGamePopupRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		
		override public function execute():void {
			// Set camera.
			cameraModel.cameraX = 0;
			cameraModel.cameraY = 100;
			cameraModel.update();
			
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			
			// Start input.
			enablePlayerInputRequest.dispatch( true );
			
			// Show game screen.
			removeFindingGamePopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
		}
	}
}
