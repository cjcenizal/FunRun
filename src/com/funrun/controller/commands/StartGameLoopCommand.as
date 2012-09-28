package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.View3dModel;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.constants.Camera;
	import com.funrun.model.state.ScreenState;
	
	import org.robotlegs.mvcs.Command;

	public class StartGameLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var startGameLoopRequest:StartGameLoopRequest;
		
		[Inject]
		public var removeFindingGamePopupRequest:RemoveFindingGamePopupRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function execute():void {
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			
			// Set camera.
			view3dModel.setTargetPerspective( 180, Camera.RUNNING_TILT, Camera.RUNNING_DISTANCE );
			view3dModel.ease.x = 1;
			view3dModel.ease.y = .2;
			view3dModel.ease.z = .65;
			view3dModel.easeHover = .5;
			view3dModel.setTargetPosition( playerModel.position.x, playerModel.position.y, playerModel.position.z );
			view3dModel.update( true );
			
			// Show game screen.
			removeFindingGamePopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
		}
	}
}
