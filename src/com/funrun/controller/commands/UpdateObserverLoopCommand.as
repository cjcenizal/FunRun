package com.funrun.controller.commands {
	
	import away3d.lights.LightBase;
	
	import com.funrun.controller.signals.EndRoundRequest;
	import com.funrun.controller.signals.FollowNewCompetitorRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.StopObserverLoopRequest;
	import com.funrun.controller.signals.UpdateCompetitorsRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.controller.signals.UpdateUiRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.LightsModel;
	import com.funrun.model.ObserverModel;
	import com.funrun.model.View3dModel;
	import com.funrun.model.vo.CompetitorVo;
	import com.funrun.model.vo.UpdateTrackVo;
	
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateObserverLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var observerModel:ObserverModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var keysModel:KeyboardModel;
		
		[Inject]
		public var lightsModel:LightsModel;
		
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
		
		// Private vars.
		
		private var _competitor:CompetitorVo;
		
		override public function execute():void {
			
			_competitor = competitorsModel.getWithId( observerModel.competitorId );
			
			// Cycle through competitors based on input.
			if ( competitorsModel.numLiveCompetitors > 1 ) {
				if ( keysModel.isDown( Keyboard.LEFT ) ) {
					keysModel.up( Keyboard.LEFT );
					followNewCompetitorRequest.dispatch( -1 );
				} else if ( keysModel.isDown( Keyboard.RIGHT ) ) {
					keysModel.up( Keyboard.RIGHT );
					followNewCompetitorRequest.dispatch( 1 );
				}
			}
			
			// Get new competitor.
			if ( needNewCompetitor() ) {
				// Get a new competitor if there are enough.
				if ( competitorsModel.numLiveCompetitors > 0 ) {
					followNewCompetitorRequest.dispatch( 1 );
				} else {
					// If there are no surviving competitors, show end results.
					endRoundRequest.dispatch();
					stopObserverLoopRequest.dispatch();
				}
			}
			
			// Update competitors' positions.
			updateCompetitorsRequest.dispatch();
			
			// Cull + rebuild track.
			updateTrackRequest.dispatch( new UpdateTrackVo( view3dModel.target.position.z ) );
			
			// Update places.
			updateUiRequest.dispatch();
			
			// Update camera.
			if ( _competitor ) {
				view3dModel.setCameraPosition( _competitor.position.x, _competitor.position.y, _competitor.position.z + 900 );
			}
			view3dModel.update();
			
			// Update lights.
			var light:LightBase = lightsModel.getLight( LightsModel.SPOTLIGHT );
			light.z = view3dModel.target.z;
			
			// Render.
			renderSceneRequest.dispatch();
			
		}
		
		private function needNewCompetitor():Boolean {
			var date:Date = new Date();
			return !_competitor ||
				( _competitor.isDead && ( date.getTime() - _competitor.deathTime > 1500 ) );
		}
	}
}
