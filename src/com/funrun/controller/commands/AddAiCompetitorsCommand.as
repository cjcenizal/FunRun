package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.DrawGameMessageRequest;
	import com.funrun.model.CharactersModel;
	import com.funrun.model.constants.Player;
	import com.funrun.model.constants.Track;
	import com.funrun.model.vo.CompetitorVo;
	import com.funrun.model.constants.PlayerProperties;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;

	public class AddAiCompetitorsCommand extends Command {

		// Arguments.
		
		[Inject]
		public var numCompetitors:int;
		
		// Models.
		
		[Inject]
		public var charactersModel:CharactersModel;
		
		// Commands.
		
		[Inject]
		public var addCompetitorRequest:AddCompetitorRequest;
		
		[Inject]
		public var displayMessageRequest:DrawGameMessageRequest;
		
		override public function execute():void {
			for ( var i:int = 0; i < numCompetitors; i++ ) {
				var competitor:CompetitorVo = new CompetitorVo( i, "Bot_" + i.toString(), charactersModel.getWithId( PlayerProperties.DEFAULT_CHARACTER ) );
				competitor.aiVelocity = new Vector3D();
				var width:Number = Track.WIDTH * .8;
				var zPos:Number = Math.random() * Player.START_POSITION_RANGE + Player.START_POSITION_MIN;
				competitor.setTargetPosition(  Math.random() * width, 0, zPos );
				addCompetitorRequest.dispatch( competitor );
				displayMessageRequest.dispatch( competitor.name + " has joined the game." );
			}
		}
	}
}
