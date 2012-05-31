package com.funrun.controller.commands {

	import com.funrun.controller.signals.RemoveCompetitorRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.RemoveResultsPopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.StopGameRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.state.ScreenState;
	
	import org.robotlegs.mvcs.Command;

	public class LeaveGameCommand extends Command {

		// Models.
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var nametagsModel:NametagsModel;
		
		// Commands.
		
		[Inject]
		public var stopGameRequest:StopGameRequest;
		
		[Inject]
		public var removeCompetitorRequest:RemoveCompetitorRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		[Inject]
		public var removeResultsPopupRequest:RemoveResultsPopupRequest;

		override public function execute():void {
			// Stop game.
			stopGameRequest.dispatch();
			// Remove competitors.
			for ( var i:int = 0; i < competitorsModel.numCompetitors; i++ ) {
				removeCompetitorRequest.dispatch( competitorsModel.getAt( i ) );
			}
			competitorsModel.reset();
			nametagsModel.reset();
			// Update screen.
			removeResultsPopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.MAIN_MENU );
		}
	}
}
