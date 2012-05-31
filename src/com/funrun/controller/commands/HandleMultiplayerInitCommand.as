package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.ObstaclesModel;
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
		public var distanceModel:DistanceModel;
		
		// Services.
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		// Commands.
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var addCompetitorRequest:AddCompetitorRequest;
		
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
			for ( var i:int = 3; i < message.length; i += 6 ) {
				if ( message.getInt( i ) != multiplayerService.playerRoomId ) {
					var competitor:CompetitorVO = new CompetitorVO(
						message.getInt( i ),
						message.getString( i + 1 )
					);
					competitor.updatePosition( message.getNumber( i + 2 ), message.getNumber( i + 3 ), distanceModel.getRelativeDistanceTo( message.getNumber( i + 4 ) ) );
					competitor.isDucking = message.getBoolean( i + 5 );
					addCompetitorRequest.dispatch( competitor );
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
