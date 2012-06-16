package com.funrun.controller.commands {

	import com.funrun.controller.signals.RemoveResultsPopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.StopGameLoopRequest;
	import com.funrun.controller.signals.StopObserverLoopRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.state.ScreenState;
	import com.funrun.services.MatchmakingService;
	import com.funrun.services.MultiplayerService;
	
	import org.robotlegs.mvcs.Command;

	public class LeaveGameCommand extends Command {

		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var stopGameLoopRequst:StopGameLoopRequest;
		
		[Inject]
		public var stopObserverLoopRequest:StopObserverLoopRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		[Inject]
		public var removeResultsPopupRequest:RemoveResultsPopupRequest;
		
		[Inject]
		public var multiplayerService:MultiplayerService;
		
		[Inject]
		public var matchmakingService:MatchmakingService;

		override public function execute():void {
			// Stop responding to time.
			stopGameLoopRequst.dispatch();
			stopObserverLoopRequest.dispatch();
			// Disconnect from server.
			multiplayerService.disconnectAndReset();
			matchmakingService.disconnectAndReset();
			// Reset in-game ID.
			playerModel.resetInGameId();
			// Update screen.
			removeResultsPopupRequest.dispatch();
			showScreenRequest.dispatch( ScreenState.MAIN_MENU );
		}
	}
}
