package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.AddPlaceableRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleMultiplayerInitCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var addCompetitorRequest:AddCompetitorRequest;
		
		[Inject]
		public var addPlaceableRequest:AddPlaceableRequest;
		
		[Inject]
		public var startGameLoopRequest:StartGameLoopRequest;
		
		override public function execute():void {
			// Store id so we can ignore updates we originated.
			playerModel.inGameId = message.getInt( 0 );
			
			// Add pre-existing competitors.
			for ( var i:int = 1; i < message.length; i += 6 ) {
				if ( message.getInt( i ) != playerModel.inGameId ) {
					var competitor:CompetitorVO = new CompetitorVO(
						message.getInt( i ),
						message.getString( i + 1 )
					);
					competitor.updatePosition( message.getNumber( i + 2 ), message.getNumber( i + 3 ), message.getNumber( i + 4 ) );
					competitor.isDucking = message.getBoolean( i + 5 );
					addCompetitorRequest.dispatch( competitor );
				}
			}
			startGameLoopRequest.dispatch();
		}
	}
}
