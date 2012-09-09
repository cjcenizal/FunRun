package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.DrawMessageRequest;
	import com.funrun.model.constants.Track;
	import com.funrun.model.constants.Player;
	import com.funrun.model.vo.CompetitorVo;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;

	public class AddAiCompetitorsCommand extends Command {

		// Arguments.
		
		[Inject]
		public var numCompetitors:int;
		
		// Commands.
		
		[Inject]
		public var addCompetitorRequest:AddCompetitorRequest;
		
		[Inject]
		public var displayMessageRequest:DrawMessageRequest;
		
		override public function execute():void {
			for ( var i:int = 0; i < numCompetitors; i++ ) {
				var competitor:CompetitorVo = new CompetitorVo( i, "Bot_" + i.toString() );
				competitor.aiVelocity = new Vector3D();
				var width:Number = Track.WIDTH * .8;
				var zPos:Number = Math.random() * Player.START_POSITION_RANGE + Player.START_POSITION_MIN;
				competitor.updatePosition(  Math.random() * width, 0, zPos );
				addCompetitorRequest.dispatch( competitor );
				displayMessageRequest.dispatch( competitor.name + " has joined the game." );
			}
		}
	}
}
