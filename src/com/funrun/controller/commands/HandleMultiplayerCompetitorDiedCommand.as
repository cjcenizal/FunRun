package com.funrun.controller.commands {

	import com.funrun.controller.signals.DrawMessageRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleMultiplayerCompetitorDiedCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var displayMessageRequest:DrawMessageRequest;
		
		override public function execute():void {
			var id:int = message.getInt( 0 );
			if ( id != playerModel.inGameId ) {
				var competitor:CompetitorVO = competitorsModel.getWithId( id );
				competitorsModel.kill( competitor.id );
				displayMessageRequest.dispatch( competitor.name + " just died!" );
			}
		}
	}
}
