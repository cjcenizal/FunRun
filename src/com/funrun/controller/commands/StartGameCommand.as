package com.funrun.controller.commands {
	
	import com.funrun.controller.events.RenderSceneRequest;
	import com.funrun.controller.events.ResetGameRequest;
	import com.funrun.controller.signals.AddFloorRequest;
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.payload.AddFloorPayload;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.GameState;
	import com.funrun.model.state.ScreenState;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * StartGameCommand starts the main game loop.
	 */
	public class StartGameCommand extends Command {
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		[Inject]
		public var addFloorRequest:AddFloorRequest;
		
		[Inject]
		public var enablePlayerInputRequest:EnablePlayerInputRequest;
		
		override public function execute():void {
			// Show game screen.
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
			// Set game state.
			gameModel.gameState = GameState.WAITING_FOR_PLAYERS;
			// Start countdown.
			countdownModel.start();
			toggleCountdownRequest.dispatch( true );
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			// Reset player.
			eventDispatcher.dispatchEvent( new ResetGameRequest( ResetGameRequest.RESET_GAME_REQUESTED ) );
			// Add initial floor.
			addFloorRequest.dispatch( new AddFloorPayload( TrackConstants.REMOVE_OBSTACLE_DEPTH, TrackConstants.TRACK_LENGTH, TrackConstants.BLOCK_SIZE ) );
			// Start input.
			enablePlayerInputRequest.dispatch( true );
			// Render to clear the view.
			eventDispatcher.dispatchEvent( new RenderSceneRequest( RenderSceneRequest.RENDER_SCENE_REQUESTED ) );
		}

	}
}
