package com.funrun.controller.commands {
	
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.vo.CompetitorVO;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;
	
	public class HandleMultiplayerUpdateCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var distanceModel:DistanceModel;
		
		// Commands.
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		override public function execute():void {
			countdownModel.secondsRemaining = message.getInt( 0 );
			var comp:CompetitorVO;
			for ( var i:int = 1; i < message.length; i += 7 ) {
				if ( message.getInt( i ) != multiplayerService.playerRoomId ) {
					comp = competitorsModel.getWithId( message.getInt( i ) );
					comp.mesh.x = message.getNumber( i + 1 );
					comp.mesh.y = message.getNumber( i + 2 );
					comp.mesh.z = distanceModel.getRelativeDistanceTo( message.getNumber( i + 3 ) );
					comp.velocity.x = message.getNumber( i + 4 );
					comp.velocity.y = message.getNumber( i + 5 );
					comp.velocity.z = message.getNumber( i + 6 );
				}
			}
		}
	}
}
