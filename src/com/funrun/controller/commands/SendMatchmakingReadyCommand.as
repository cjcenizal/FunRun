package com.funrun.controller.commands
{
	import com.funrun.controller.signals.ToggleReadyButtonRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Messages;
	import com.funrun.services.GameService;
	import com.funrun.services.MatchmakingService;
	
	import org.robotlegs.mvcs.Command;
	
	public class SendMatchmakingReadyCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Services.
		
		[Inject]
		public var gameService:GameService;
		
		[Inject]
		public var matchmakingService:MatchmakingService;
		
		// Commands.
		
		[Inject]
		public var toggleReadyButtonRequest:ToggleReadyButtonRequest;
		
		override public function execute():void
		{
			matchmakingService.send( Messages.READY );
			gameService.send( Messages.READY );
			toggleReadyButtonRequest.dispatch( false );
		}
	}
}