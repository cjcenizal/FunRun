package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.DisplayMessageRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateAiCompetitorsCommand extends Command {
		
		// Models.
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var interpolationModel:InterpolationModel;
		
		[Inject]
		public var displayMessageRequest:DisplayMessageRequest;
		
		[Inject]
		public var timeModel:TimeModel;
		
		override public function execute():void {
			// Update positions.
			interpolationModel.reset();
			var competitor:CompetitorVO;
			var killed:Boolean = false;
			for ( var i:int = 0; i < competitorsModel.numCompetitors; i++ ) {
				competitor = competitorsModel.getAt( i );
				if ( !competitor.isDead ) {
					if ( !killed && timeModel.ticks > ( 30 * 4 ) && timeModel.ticks % 40 == 0 ) {
						competitorsModel.kill( competitor.id );
						displayMessageRequest.dispatch( competitor.name + " just died!" );
						killed = true;
					} else {
						competitor.updatePosition( competitor.position.x, competitor.position.y, competitor.position.z + Math.random() * TrackConstants.MAX_PLAYER_FORWARD_VELOCITY + TrackConstants.MAX_PLAYER_FORWARD_VELOCITY * .25 );
					}
				}
			}
		}
	}
}
