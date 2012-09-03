package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.DrawMessageRequest;
	import com.funrun.model.constants.Track;
	import com.funrun.model.vo.CompetitorVo;
	
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
				var width:Number = Track.WIDTH * .8;
				competitor.updatePosition(  Math.random() * width, 0, Math.random() * 300 );
				addCompetitorRequest.dispatch( competitor );
				displayMessageRequest.dispatch( competitor.name + " has joined the game." );
			}
		}
	}
}
