package com.funrun.controller.commands {

	import com.funrun.controller.signals.DrawGameMessageRequest;
	import com.funrun.controller.signals.LogMessageRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.vo.CompetitorVo;
	import com.funrun.controller.signals.vo.LogMessageVo;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleGameCompetitorDiedCommand extends Command {
		
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
		public var displayMessageRequest:DrawGameMessageRequest;
		
		[Inject]
		public var logMessageRequest:LogMessageRequest;
		
		override public function execute():void {
			var id:int = message.getInt( 0 );
			if ( id != playerModel.inGameId ) {
				var competitor:CompetitorVo = competitorsModel.getWithId( id );
				competitorsModel.kill( competitor.id );
				displayMessageRequest.dispatch( competitor.name + " just died!" );
			}
		}
	}
}
