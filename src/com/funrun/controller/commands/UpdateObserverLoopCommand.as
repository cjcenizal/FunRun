package com.funrun.controller.commands {

	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.ShowResultsPopupRequest;
	import com.funrun.controller.signals.StopObserverLoopRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.controller.signals.payload.UpdateTrackPayload;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.ObserverModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.ObserverConstants;
	import com.funrun.model.vo.CompetitorVO;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateObserverLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3DModel:View3DModel;
		
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
		public var showResultsPopupRequest:ShowResultsPopupRequest;
		
		[Inject]
		public var stopObserverLoopRequest:StopObserverLoopRequest;
		
		override public function execute():void {
			// If we are observing a live competitor, continue following him.
			// TO-DO: Implement a timer to watch a dead competitor for a few seconds before switching.
			var competitor:CompetitorVO = competitorsModel.getWithId( observerModel.competitorId );
			if ( competitor && !competitor.isDead ) {
				observerModel.z = competitor.mesh.position.z + ObserverConstants.CAM_Z;
				updateTrackRequest.dispatch( new UpdateTrackPayload( competitor.mesh.position.z ) );
				
				// Update camera.
				view3DModel.cameraZ = observerModel.z;
				view3DModel.lookAt( competitor.mesh.position );
				view3DModel.update();
				
				// Render.
				renderSceneRequest.dispatch();
				
			} else {
				// Else, try to follow a new competitor.
				if ( competitorsModel.numLiveCompetitors > 0 ) {
					//followNextCompetitorRequest.dispatch()
				} else {
					// If there are no surviving competitors, show end results.
					showResultsPopupRequest.dispatch();
					stopObserverLoopRequest.dispatch();
				}
			}
			
			
		}
	}
}
