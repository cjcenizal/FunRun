package com.funrun.controller.commands {

	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.constants.RoomTypes;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;
	import com.funrun.model.vo.PlayerioErrorVO;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	/**
	 * ConnectMultiplayerCommand displays a "finding game" panel,
	 * and then connects to a room (or gets an error and show feedback).
	 * The room tells us how much time is remaining, and controls the countdown.
	 * When the countdown is up, the room tells us to start the game.
	 */
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
		
		[Inject]
		public var showFindingGamePopupRequest:ShowFindingGamePopupRequest;
		
		[Inject]
		public var removeFindingGamePopupRequest:RemoveFindingGamePopupRequest;
		
		[Inject]
		public var showPlayerioErrorPopupRequest:ShowPlayerioErrorPopupRequest;
		
		override public function execute():void {
			// Hide view and block interaction.
			showFindingGamePopupRequest.dispatch();
			// Set up multiplayer.
			multiplayerService.onConnectedSignal.add( onConnected );
			multiplayerService.onErrorSignal.add( onError );
			// One frame delay.
			contextView.stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function onEnterFrame( e:Event ):void {
			contextView.stage.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			// Get a room!
			multiplayerService.connect( loginService.client, RoomTypes.GAME );
		}
		
		private function onConnected():void {
			multiplayerService.addMessageHandler( "init", onInit );
			multiplayerService.addMessageHandler( "update", onUpdate );
		}
		
		private function onError():void {
			showPlayerioErrorPopupRequest.dispatch( new PlayerioErrorVO( multiplayerService.error ) );
		}
		
		private function onInit( message:Message ):void {
			// Store id so we can ignore updates we originated.
			multiplayerService.roomId = message.getInt( 0 );
			// Initialize countdown.
			countdownModel.secondsRemaining = message.getInt( 1 );
			toggleCountdownRequest.dispatch( true );
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			// Start input.
			enablePlayerInputRequest.dispatch( true );
			// Show game screen.
			removeFindingGamePopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
		}
		
		private function onUpdate( message:Message ):void {
			countdownModel.secondsRemaining = message.getInt( 0 );
		}
	}
}
