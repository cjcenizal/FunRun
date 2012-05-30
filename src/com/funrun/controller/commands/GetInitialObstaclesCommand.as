package com.funrun.controller.commands {

	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.state.GameState;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class GetInitialObstaclesCommand extends Command {
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var distanceModel:DistanceModel;
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		[Inject]
		public var startRunningRequest:StartRunningRequest;
		
		override public function execute():void {
			// Set game state.
			gameModel.gameState = GameState.WAITING_FOR_INITIAL_OBSTACLES;
			// Listen for obstacles to be returned.
			multiplayerService.addMessageHandler( "o", onNewObstacles );
			// Request them.
			multiplayerService.send( "o", distanceModel.distance );
		}
		
		private function onNewObstacles( message:Message ):void {
			trace(this, "onNewObstacles");
			// On return, stop listening and dispatch start running.
			multiplayerService.removeMessageHandler( "o", onNewObstacles );
			startRunningRequest.dispatch();
		}
	}
}
