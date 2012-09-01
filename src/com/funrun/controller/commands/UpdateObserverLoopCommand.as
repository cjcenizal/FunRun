package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EndRoundRequest;
	import com.funrun.controller.signals.FollowNewCompetitorRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.StopObserverLoopRequest;
	import com.funrun.controller.signals.UpdateCompetitorsRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.controller.signals.UpdateUiRequest;
	import com.funrun.controller.signals.payload.UpdateTrackPayload;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.ObserverModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateObserverLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3dModel:View3DModel;
		
		[Inject]
		public var observerModel:ObserverModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		[Inject]
		public var updateTrackRequest:UpdateTrackRequest;
		
		[Inject]
		public var updateCompetitorsRequest:UpdateCompetitorsRequest;
		
		[Inject]
		public var updateUiRequest:UpdateUiRequest;
		
		[Inject]
		public var followNewCompetitorRequest:FollowNewCompetitorRequest;
		
		[Inject]
		public var endRoundRequest:EndRoundRequest;
		
		[Inject]
		public var stopObserverLoopRequest:StopObserverLoopRequest;
		
		override public function execute():void {
			
			var competitor:CompetitorVO = competitorsModel.getWithId( observerModel.competitorId );
			var date:Date = new Date();
			if ( !competitor ||
				( competitor.isDead && ( date.getTime() - competitor.deathTime > 1500 ) ) ) {
				// Else, try to follow a new competitor.
				if ( competitorsModel.numLiveCompetitors > 0 ) {
					followNewCompetitorRequest.dispatch( 1 );
				} else {
					// If there are no surviving competitors, show end results.
					endRoundRequest.dispatch();
					stopObserverLoopRequest.dispatch();
				}
			} else {
				// Update competitors' positions.
				updateCompetitorsRequest.dispatch();
				
				// Cull + rebuild track.
				updateTrackRequest.dispatch( new UpdateTrackPayload( view3dModel.target.position.z ) );
				
				// Update places.
				updateUiRequest.dispatch();
				
				// Update camera.
				view3dModel.setCameraPosition( competitor.position.x, competitor.position.y, competitor.position.z + 900 );
				view3dModel.update();
				
				// Render.
				renderSceneRequest.dispatch();
			}
		}
	}
}
