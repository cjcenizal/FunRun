package com.funrun.controller.commands
{
	import com.funrun.controller.signals.ResetGameRequest;
	import com.funrun.controller.signals.StartCountdownRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.model.GameModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class JoinSinglePlayerGameCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var gameModel:GameModel;
		
		// Commands.
		
		[Inject]
		public var resetGameRequest:ResetGameRequest;
		
		[Inject]
		public var startCountdownRequest:StartCountdownRequest;
		
		[Inject]
		public var startGameLoopRequest:StartGameLoopRequest;

		override public function execute():void
		{
			gameModel.isMultiplayer = false;
			// Reset game.
			resetGameRequest.dispatch();
			startCountdownRequest.dispatch();
			startGameLoopRequest.dispatch();
		}
	}
}