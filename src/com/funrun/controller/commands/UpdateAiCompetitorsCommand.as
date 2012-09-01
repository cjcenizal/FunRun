package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.DrawMessageRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.constants.Player;
	import com.funrun.model.StateModel;
	import nl.ronvalstar.math.Perlin;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateAiCompetitorsCommand extends Command {
		
		// Models.
		
		[Inject]
		public var stateModel:StateModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var interpolationModel:InterpolationModel;
		
		[Inject]
		public var displayMessageRequest:DrawMessageRequest;
		
		[Inject]
		public var timeModel:TimeModel;
		
		override public function execute():void {
			if ( stateModel.isRunning() ) {
				// Update positions.
				interpolationModel.reset();
				var competitor:CompetitorVO;
				var killed:Boolean = false;
				for ( var i:int = 0; i < competitorsModel.numCompetitors; i++ ) {
					competitor = competitorsModel.getAt( i );
					if ( !competitor.isDead ) {
						if ( !killed && timeModel.ticks > ( 30 * 4 ) && timeModel.ticks % 200 == 0 ) {
							competitorsModel.kill( competitor.id );
							displayMessageRequest.dispatch( competitor.name + " just died!" );
							killed = true;
						} else {
							var rand:Number = Perlin.noise( i * 2, timeModel.ticks * .01 );
							var speed:Number = rand * ( Player.MAX_FORWARD_VELOCITY * 2 );
							competitor.updatePosition( competitor.position.x, competitor.position.y, competitor.position.z + speed );
						}
					}
				}
			}
		}
	}
}
