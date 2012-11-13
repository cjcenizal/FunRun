package com.funrun.controller.commands {
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.UpdateAiCompetitorsRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.vo.CompetitorVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateCompetitorsCommand extends Command {
		
		// Models.
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var interpolationModel:InterpolationModel;
		
		// Commands.
		
		[Inject]
		public var updateAiCompetitorsRequest:UpdateAiCompetitorsRequest;
		
		override public function execute():void {
			// Update AI.
			if ( !gameModel.isOnline ) {
				updateAiCompetitorsRequest.dispatch();
			}
			
			// Interpolate competitor position.
			var len:int = competitorsModel.numCompetitors;
			var competitor:CompetitorVo;
			var nametag:AbstractLabel;
			for ( var i:int = 0; i < len; i++ ) {
				competitor = competitorsModel.getAt( i );
				competitor.interpolateToTargetPosition( interpolationModel.percent );
				competitor.updatePosition();
			}
			interpolationModel.increment();
		}
	}
}
