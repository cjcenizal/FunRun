package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddFloorRequest;
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.ResetGameRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.payload.AddFloorPayload;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.constants.RoomTypes;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.GameState;
	import com.funrun.model.state.ScreenState;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

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
		
		[Inject]
		public var resetGameRequest:ResetGameRequest;
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		override public function execute():void {
			// Show game screen.
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
			// Set game state.
			gameModel.gameState = GameState.WAITING_FOR_PLAYERS;
			// Connect to room.
			multiplayerService.onConnectedSignal.add( onConnected );
			multiplayerService.onErrorSignal.add( onError );
			multiplayerService.connect( loginService.client, RoomTypes.GAME );
			
			/*
				1) Display "finding game" panel
				2) Connect to room or error, and show feedback
				3) Room tells us how much time is remaining, and controls the countdown
				4) When countdown is up, room tells us to start the game
			*/
			
			/*
			// Start countdown.
			countdownModel.start();
			toggleCountdownRequest.dispatch( true );
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			// Reset game.
			resetGameRequest.dispatch();
			// Add initial floor.
			addFloorRequest.dispatch( new AddFloorPayload( TrackConstants.REMOVE_OBSTACLE_DEPTH, TrackConstants.TRACK_LENGTH, TrackConstants.BLOCK_SIZE ) );
			// Start input.
			enablePlayerInputRequest.dispatch( true );
			// Render to clear the view.
			renderSceneRequest.dispatch();
			*/
		}
		
		private function onConnected():void {
			trace(this, "connected");
			multiplayerService.connection.addMessageHandler( "update", onUpdate );
		}
		
		private function onError():void {
			trace(this, "error");
		}
		
		private function onUpdate( message:Message, secondsRemaining:int ):void {
			trace("secondsRemaining");
		}
	}
}
