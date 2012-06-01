package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.AddPlaceableRequest;
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.UserModel;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleMultiplayerInitCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var distanceModel:DistanceModel;
		
		[Inject]
		public var userModel:UserModel;
		
		// Commands.
		
		[Inject]
		public var addCompetitorRequest:AddCompetitorRequest;
		
		[Inject]
		public var enablePlayerInputRequest:EnablePlayerInputRequest;
		
		[Inject]
		public var removeFindingGamePopupRequest:RemoveFindingGamePopupRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		[Inject]
		public var addPlaceableRequest:AddPlaceableRequest;
		
		override public function execute():void {
			// Store id so we can ignore updates we originated.
			userModel.inGameId = message.getInt( 0 );
			
			// Add pre-existing competitors.
			for ( var i:int = 1; i < message.length; i += 6 ) {
				if ( message.getInt( i ) != userModel.inGameId ) {
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
