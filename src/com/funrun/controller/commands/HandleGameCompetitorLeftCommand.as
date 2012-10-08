package com.funrun.controller.commands {

	import com.funrun.controller.signals.DrawGameMessageRequest;
	import com.funrun.controller.signals.DrawReadyListRequest;
	import com.funrun.controller.signals.LogMessageRequest;
	import com.funrun.controller.signals.RemoveCompetitorRequest;
	import com.funrun.controller.signals.vo.LogMessageVo;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.vo.CompetitorVo;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleGameCompetitorLeftCommand extends Command {

		// Arguments.

		[Inject]
		public var message:Message;

		// Models.
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var removeCompetitorRequest:RemoveCompetitorRequest;
		
		[Inject]
		public var displayMessageRequest:DrawGameMessageRequest;
		
		[Inject]
		public var logMessageRequest:LogMessageRequest;
		
		[Inject]
		public var drawReadyListRequest:DrawReadyListRequest;
		
		override public function execute():void {
			var inGameId:int = message.getInt( 0 );
			var competitor:CompetitorVo = competitorsModel.getWithId( inGameId );
			removeCompetitorRequest.dispatch( competitor );
			displayMessageRequest.dispatch( competitor.name + " has left the game." );
			logMessageRequest.dispatch( new LogMessageVo( this, "Competitor " + competitor.id + " (" + competitor.name + ") left the game." ) );
			drawReadyListRequest.dispatch();
		}
	}
}
