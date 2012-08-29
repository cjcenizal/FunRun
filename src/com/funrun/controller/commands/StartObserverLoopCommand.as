package com.funrun.controller.commands {
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.StopGameLoopRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.ObserverModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.ObserverConstants;
	import com.funrun.model.events.TimeEvent;
	import com.funrun.model.state.ScreenState;
	import com.funrun.model.vo.CompetitorVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class StartObserverLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3DModel:View3DModel;
		
		[Inject]
		public var observerModel:ObserverModel;
		
		[Inject]
		public var nametagsModel:NametagsModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var stopGameLoopRequest:StopGameLoopRequest;
		
		[Inject]
		public var removeFindingGamePopupRequest:RemoveFindingGamePopupRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function execute():void {
			// Stop game loop.
			stopGameLoopRequest.dispatch();
			
			// Move nametags out of the way.
			var len:int = competitorsModel.numCompetitors;
			var competitor:CompetitorVO;
			var nametag:AbstractLabel;
			for ( var i:int = 0; i < len; i++ ) {
				competitor = competitorsModel.getAt( i );
				nametag = nametagsModel.getWithId( competitor.id.toString() );
				if ( nametag ) {
					nametag.x = -500;
				}
			}
			
			// Set up observer.
			observerModel.reset();
			observerModel.x = ObserverConstants.CAM_X;
			observerModel.y = ObserverConstants.CAM_Y;
			observerModel.z = ObserverConstants.CAM_Z;
			
			// Set camera.
			view3DModel.setCameraPosition( observerModel.x, observerModel.y, observerModel.z );
			
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateObserverLoopCommand, TimeEvent );
			
			// TEMP: Show game screen.
			removeFindingGamePopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.MULTIPLAYER_GAME );
		}
	}
}
