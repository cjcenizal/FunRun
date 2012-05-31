package com.funrun.controller.commands {

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
		
		override public function execute():void {
			var comp:CompetitorVO = competitorsModel.getWithId( message.getInt( 0 ) );
			removeCompetitorRequest.dispatch( comp );
		}
	}
}
