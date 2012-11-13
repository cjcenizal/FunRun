package com.funrun.controller.commands {
	
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Player;
	import com.funrun.model.vo.CompetitorVo;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;
	
	public class HandleGameUpdateCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var interpolationModel:InterpolationModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		override public function execute():void {
			interpolationModel.reset();
			var competitor:CompetitorVo;
			for ( var i:int = 0; i < message.length; i += 5 ) {
				var id:int = message.getInt( i );
				if ( id != playerModel.inGameId ) {
					competitor = competitorsModel.getWithId( id );
					// Sometimes comp returns null for some reason.
					if ( competitor ) {
						competitor.hardUpdatePosition();
						competitor.setTargetPosition(
							message.getNumber( i + 1 ),
							message.getNumber( i + 2 ),
							message.getNumber( i + 3 )
							);
						competitor.isDucking = message.getBoolean( i + 4 );
						if ( competitor.isDucking ) {
							if ( competitor.mesh.scaleY != Player.DUCKING_SCALE ) {
								competitor.mesh.scaleY = Player.DUCKING_SCALE;
							}
						} else {
							if ( competitor.mesh.scaleY != 1 ) {
								competitor.mesh.scaleY = 1;
							}
						}
					}
				}
			}
		}
	}
}
