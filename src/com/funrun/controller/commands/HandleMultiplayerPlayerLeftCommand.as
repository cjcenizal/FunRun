package com.funrun.controller.commands {

	import com.funrun.controller.signals.DisplayMessageRequest;
	import com.funrun.controller.signals.RemoveCompetitorRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleMultiplayerPlayerLeftCommand extends Command {

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
		public var displayMessageRequest:DisplayMessageRequest;
		
		override public function execute():void {
			var competitor:CompetitorVO = competitorsModel.getWithId( message.getInt( 0 ) );
			removeCompetitorRequest.dispatch( competitor );
			displayMessageRequest.dispatch( competitor.name + " has left the game." );
		}
	}
}
