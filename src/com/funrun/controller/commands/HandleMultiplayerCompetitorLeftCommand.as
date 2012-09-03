package com.funrun.controller.commands {

	import com.funrun.controller.signals.DrawMessageRequest;
	import com.funrun.controller.signals.RemoveCompetitorRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.vo.CompetitorVo;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleMultiplayerCompetitorLeftCommand extends Command {

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
		public var displayMessageRequest:DrawMessageRequest;
		
		override public function execute():void {
			var competitor:CompetitorVo = competitorsModel.getWithId( message.getInt( 0 ) );
			removeCompetitorRequest.dispatch( competitor );
			displayMessageRequest.dispatch( competitor.name + " has left the game." );
		}
	}
}
