package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.DrawMessageRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleMultiplayerCompetitorJoinedCommand extends Command {
		
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
		public var displayMessageRequest:DrawMessageRequest;
		
		override public function execute():void {
			// We receive ourselves as new players, so screen ourselves out.
			if ( message.getInt( 0 ) != playerModel.inGameId ) {
				var competitor:CompetitorVO = new CompetitorVO(
					message.getInt( 0 ),
					message.getString( 1 )
				);
				competitor.updatePosition( message.getNumber( 2 ), message.getNumber( 3 ), message.getNumber( 4 ) );
				competitor.isDucking = message.getBoolean( 5 );
				addCompetitorRequest.dispatch( competitor );
				displayMessageRequest.dispatch( competitor.name + " has joined the game." );
			}
		}
	}
}
