package com.funrun.controller.commands {

	import com.funrun.controller.signals.DisplayMessageRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.UserModel;
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
		public var userModel:UserModel;
		
		// Commands.
		
		[Inject]
		public var displayMessageRequest:DisplayMessageRequest;
		
		override public function execute():void {
			var id:int = message.getInt( 0 );
			if ( id != userModel.inGameId ) {
				var competitor:CompetitorVO = competitorsModel.getWithId( id );
				competitorsModel.kill( competitor.id );
				displayMessageRequest.dispatch( competitor.name + " just died!" );
			}
		}
	}
}
