package com.funrun.controller.commands {

	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.ObserverModel;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class FollowNewCompetitorCommand extends Command {

		// Arguments.

		[Inject]
		public var increment:int;

		// Models.

		[Inject]
		public var observerModel:ObserverModel;

		[Inject]
		public var competitorsModel:CompetitorsModel;


		override public function execute():void {
			var competitor:CompetitorVO = competitorsModel.getWithId( observerModel.competitorId );
			if ( !competitor ) {
				competitor = competitorsModel.getLiveCompetitorAt( 0 );
			} else {
				var index:int = ( competitor.liveIndex >= competitorsModel.numLiveCompetitors - 1 ) ? 0 : competitor.liveIndex + 1;
				competitor = competitorsModel.getLiveCompetitorAt( index );
			}
			observerModel.competitorId = competitor.id;
		}
	}
}
