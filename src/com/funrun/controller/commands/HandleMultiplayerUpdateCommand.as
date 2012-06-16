package com.funrun.controller.commands {
	
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.UserModel;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;
	
	public class HandleMultiplayerUpdateCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var interpolationModel:InterpolationModel;
		
		[Inject]
		public var userModel:UserModel;
		
		override public function execute():void {
			interpolationModel.reset();
			var competitor:CompetitorVO;
			for ( var i:int = 0; i < message.length; i += 5 ) {
				if ( message.getInt( i ) != userModel.inGameId ) {
					competitor = competitorsModel.getWithId( message.getInt( i ) );
					// Sometimes comp returns null for some reason.
					if ( competitor ) {
						competitor.hardUpdate();
						competitor.updatePosition(
							message.getNumber( i + 1 ),
							message.getNumber( i + 2 ),
							message.getNumber( i + 3 )
							);
						competitor.isDucking = message.getBoolean( i + 4 );
						if ( competitor.isDucking ) {
							if ( competitor.mesh.scaleY != .25 ) {
								competitor.mesh.scaleY = .25;
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
