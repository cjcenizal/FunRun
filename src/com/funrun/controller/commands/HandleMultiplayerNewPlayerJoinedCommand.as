package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.DisplayMessageRequest;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.UserModel;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleMultiplayerNewPlayerJoinedCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var distanceModel:DistanceModel;
		
		[Inject]
		public var userModel:UserModel;
		
		// Commands.
		
		[Inject]
		public var addCompetitorRequest:AddCompetitorRequest;
		
		[Inject]
		public var displayMessageRequest:DisplayMessageRequest;
		
		override public function execute():void {
			if ( message.getInt( 0 ) != userModel.inGameId ) {
				var competitor:CompetitorVO = new CompetitorVO(
					message.getInt( 0 ),
					message.getString( 1 )
				);
				competitor.updatePosition( message.getNumber( 2 ), message.getNumber( 3 ), distanceModel.getRelativeDistanceTo( message.getNumber( 4 ) ) );
				competitor.isDucking = message.getBoolean( 5 );
				addCompetitorRequest.dispatch( competitor );
				displayMessageRequest.dispatch( competitor.name + " has joined the game." );
			} else {
				trace(this, "ERROR: The new player is us." );
			}
		}
	}
}
