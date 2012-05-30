package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.primitives.CylinderGeometry;
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;
	import com.funrun.model.vo.CompetitorVO;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleMultiplayerInitCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var obstaclesModel:ObstaclesModel;
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var distanceModel:DistanceModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		// Services.
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		// Commands.
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var enablePlayerInputRequest:EnablePlayerInputRequest;
		
		[Inject]
		public var removeFindingGamePopupRequest:RemoveFindingGamePopupRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function execute():void {
			// Store id so we can ignore updates we originated.
			multiplayerService.playerRoomId = message.getInt( 0 );
			// Store random seed.
			obstaclesModel.seed = message.getInt( 1 );
			// Initialize countdown.
			countdownModel.secondsRemaining = message.getInt( 2 );
			toggleCountdownRequest.dispatch( true );
			
			// Add pre-existing competitors.
			for ( var i:int = 3; i < message.length; i += 7 ) {
				if ( message.getInt( i ) != multiplayerService.playerRoomId ) {
					var mesh:Mesh = new Mesh( new CylinderGeometry( TrackConstants.PLAYER_RADIUS * .9, TrackConstants.PLAYER_RADIUS, TrackConstants.PLAYER_HALF_SIZE * 2 ), materialsModel.getMaterial( MaterialsModel.PLAYER_MATERIAL ) );
					mesh.x = message.getNumber( i + 1 );
					mesh.y = message.getNumber( i + 2 );
					mesh.z = distanceModel.getRelativeDistanceTo( message.getNumber( i + 3 ) );
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
	}
}
