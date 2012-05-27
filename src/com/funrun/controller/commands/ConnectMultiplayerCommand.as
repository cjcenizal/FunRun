package com.funrun.controller.commands {

	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.constants.RoomTypes;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class ConnectMultiplayerCommand extends Command {
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var enablePlayerInputRequest:EnablePlayerInputRequest;
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function execute():void {
			/*
			1) Display "finding game" panel
			2) Connect to room or error, and show feedback
			3) Room tells us how much time is remaining, and controls the countdown
			4) When countdown is up, room tells us to start the game
			*/
			// Connect to room.
			multiplayerService.onConnectedSignal.add( onConnected );
			multiplayerService.onErrorSignal.add( onError );
			multiplayerService.connect( loginService.client, RoomTypes.GAME );
		}
		
		private function onConnected():void {
			trace(this, "connected");
			multiplayerService.connection.addMessageHandler( "init", onInit );
			multiplayerService.connection.addMessageHandler( "update", onUpdate );
		}
		
		private function onError():void {
			trace(this, "error");
		}
		
		private function onInit( message:Message ):void {
			// TO-DO: Store id so we can ignore updates we originated.
			trace("on init ");
			
			// Initialize countdown.
			//countdownModel.secondsRemaining = secondsRemaining;
			toggleCountdownRequest.dispatch( true );
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			
			// Start input.
			enablePlayerInputRequest.dispatch( true );
			
			// Show game screen.
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
		}
		
		private function onUpdate( message:Message, secondsRemaining:int ):void {
			countdownModel.secondsRemaining = secondsRemaining;
		}
	}
}
