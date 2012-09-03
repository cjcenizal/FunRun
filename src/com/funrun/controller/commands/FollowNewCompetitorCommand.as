package com.funrun.controller.commands {

	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.ObserverModel;
	import com.funrun.model.View3dModel;
	import com.funrun.model.vo.CompetitorVo;
	
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

		[Inject]
		public var view3DModel:View3dModel;

		override public function execute():void {
			var competitor:CompetitorVo = competitorsModel.getWithId( observerModel.competitorId );
			if ( !competitor ) {
				competitor = competitorsModel.getLiveCompetitorAt( 0 );
			} else {
				var index:int = competitor.liveIndex + increment;
				if ( index >= competitorsModel.numLiveCompetitors ) {
					index = 0;
				} else if ( index < 0 ) {
					index = competitorsModel.numLiveCompetitors - 1;
				}
				competitor = competitorsModel.getLiveCompetitorAt( index );
			}
			observerModel.competitorId = competitor.id;
			view3DModel.setCameraPosition( competitor.position.x, competitor.position.y, competitor.position.z );
			view3DModel.update();
		}
	}
}
