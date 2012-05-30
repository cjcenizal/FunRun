package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.vo.CompetitorVO;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleMultiplayerNewPlayerJoinedCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var distanceModel:DistanceModel;
		
		// Services.
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		// Commands.
		
		[Inject]
		public var addCompetitorRequest:AddCompetitorRequest;
		
		override public function execute():void {
			if ( message.getInt( 0 ) != multiplayerService.playerRoomId ) {
				var competitor:CompetitorVO = new CompetitorVO(
					message.getInt( 0 ),
					message.getString( 1 ),
					new Vector3D( message.getNumber( 5 ), message.getNumber( 6 ), message.getNumber( 7 ) ),
					false,
					false
				);
				competitor.updatePosition( message.getNumber( 2 ), message.getNumber( 3 ), distanceModel.getRelativeDistanceTo( message.getNumber( 4 ) ) );
				addCompetitorRequest.dispatch( competitor );
			}
		}
	}
}
