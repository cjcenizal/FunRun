package com.funrun.controller.commands {

	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.RemoveResultsPopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.state.ScreenState;
	
	import org.robotlegs.mvcs.Command;

	public class LeaveGameCommand extends Command {

		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		[Inject]
		public var removeResultsPopupRequest:RemoveResultsPopupRequest;

		override public function execute():void {
			// Remove competitors.
			for ( var i:int = 0; i < competitorsModel.numCompetitors; i++ ) {
				removeObjectFromSceneRequest.dispatch( competitorsModel.getAt( i ).mesh );
			}
			competitorsModel.reset();
			// Update screen.
			removeResultsPopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.MAIN_MENU );
		}
	}
}
