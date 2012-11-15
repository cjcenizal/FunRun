package com.funrun.controller.commands {

	import com.funrun.controller.signals.JoinLobbyRequest;
	import com.funrun.controller.signals.RemoveResultsPopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.StopGameLoopRequest;
	import com.funrun.controller.signals.StopObserverLoopRequest;
	import com.funrun.model.DelayedCommandsModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Screen;
	import com.funrun.services.GameService;
	import com.funrun.services.MatchmakingService;
	
	import org.robotlegs.mvcs.Command;

	public class LeaveGameCommand extends Command {

		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var delayedCommandsModel:DelayedCommandsModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		// Services.
		
		[Inject]
		public var multiplayerService:GameService;
		
		[Inject]
		public var matchmakingService:MatchmakingService;
		
		// Commands.
		
		[Inject]
		public var stopGameLoopRequst:StopGameLoopRequest;
		
		[Inject]
		public var stopObserverLoopRequest:StopObserverLoopRequest;
		
		[Inject]
		public var removeResultsPopupRequest:RemoveResultsPopupRequest;
		
		[Inject]
		public var joinLobbyRequest:JoinLobbyRequest;

		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function execute():void {
			// Remove delayed commands.
			delayedCommandsModel.removeAll();
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
			if ( gameModel.isMultiplayer ) {
				joinLobbyRequest.dispatch();
			} else {
				// Show main menu.
				showScreenRequest.dispatch( Screen.MAIN_MENU );
			}
		}
	}
}
