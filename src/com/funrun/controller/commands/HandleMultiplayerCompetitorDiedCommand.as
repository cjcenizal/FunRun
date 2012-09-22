package com.funrun.controller.commands {

	import com.funrun.controller.signals.DrawMessageRequest;
	import com.funrun.controller.signals.LogMessageRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.vo.CompetitorVo;
	import com.funrun.model.vo.LogMessageVo;
	
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
		
		[Inject]
		public var logMessageRequest:LogMessageRequest;
		
		override public function execute():void {
			var id:int = message.getInt( 0 );
			if ( id != playerModel.inGameId ) {
				var competitor:CompetitorVo = competitorsModel.getWithId( id );
				competitorsModel.kill( competitor.id );
				displayMessageRequest.dispatch( competitor.name + " just died!" );
				logMessageRequest.dispatch( new LogMessageVo( this, "Competitor " + competitor.id + " (" + competitor.name + ") died." ) );
			}
		}
	}
}
