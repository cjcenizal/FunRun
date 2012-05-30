package com.funrun.controller.commands {

	import away3d.entities.Mesh;
	import away3d.primitives.CylinderGeometry;
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.RoomTypes;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;
	import com.funrun.model.vo.CompetitorVO;
	import com.funrun.model.vo.PlayerioErrorVO;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import flash.events.Event;
	import flash.geom.Vector3D;
	
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
		public var obstaclesModel:ObstaclesModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		[Inject]
		public var distanceModel:DistanceModel;
		
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
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
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
			multiplayerService.addMessageHandler( "i", onInit );
			multiplayerService.addMessageHandler( "u", onUpdate );
			multiplayerService.addMessageHandler( "n", onNewPlayerJoined );
		}
		
		private function onError():void {
			showPlayerioErrorPopupRequest.dispatch( new PlayerioErrorVO( multiplayerService.error ) );
		}
		
		private function onInit( message:Message ):void {
			// Store id so we can ignore updates we originated.
			multiplayerService.roomId = message.getInt( 0 );
			// Store random seed.
			obstaclesModel.seed = message.getInt( 1 );
			// Initialize countdown.
			countdownModel.secondsRemaining = message.getInt( 2 );
			toggleCountdownRequest.dispatch( true );
			
			// Add pre-existing players.
			for ( var i:int = 3; i < message.length; i += 7 ) {
				if ( message.getInt( i ) != multiplayerService.roomId ) {
					var mesh:Mesh = new Mesh( new CylinderGeometry( TrackConstants.PLAYER_RADIUS * .9, TrackConstants.PLAYER_RADIUS, TrackConstants.PLAYER_HALF_SIZE * 2 ), materialsModel.getMaterial( MaterialsModel.PLAYER_MATERIAL ) );
					mesh.x = message.getNumber( i + 1 );
					mesh.y = message.getNumber( i + 2 );
					mesh.z = message.getNumber( i + 3 ) - distanceModel.z;
					competitorsModel.add( new CompetitorVO(
						message.getInt( i ),
						mesh,
						new Vector3D( message.getNumber( i + 4 ), message.getNumber( i + 5 ), message.getNumber( i + 6 ) ),
						false,
						false ) );
					addObjectToSceneRequest.dispatch( mesh );
				}
			}
			
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
			var comp:CompetitorVO;
			for ( var i:int = 1; i < message.length; i += 7 ) {
				if ( message.getInt( i ) != multiplayerService.roomId ) {
					comp = competitorsModel.getWithId( message.getInt( i ) );
					comp.mesh.x = message.getNumber( i + 1 );
					comp.mesh.y = message.getNumber( i + 2 );
					comp.mesh.z = message.getNumber( i + 3 ) - distanceModel.z;
					comp.velocity.x = message.getNumber( i + 4 );
					comp.velocity.y = message.getNumber( i + 5 );
					comp.velocity.z = message.getNumber( i + 6 );
				}
			}
		}
		
		private function onNewPlayerJoined( message:Message ):void {
			if ( message.getInt( 0 ) != multiplayerService.roomId ) {
				var mesh:Mesh = new Mesh( new CylinderGeometry( TrackConstants.PLAYER_RADIUS * .9, TrackConstants.PLAYER_RADIUS, TrackConstants.PLAYER_HALF_SIZE * 2 ), materialsModel.getMaterial( MaterialsModel.PLAYER_MATERIAL ) );
				mesh.x = message.getNumber( 1 );
				mesh.y = message.getNumber( 2 );
				mesh.z = message.getNumber( 3 ) - distanceModel.z;
				competitorsModel.add( new CompetitorVO(
					message.getInt( 0 ),
					mesh,
					new Vector3D( message.getNumber( 4 ), message.getNumber( 5 ), message.getNumber( 6 ) ),
					false,
					false ) );
				addObjectToSceneRequest.dispatch( mesh );
			}
		}
	}
}
