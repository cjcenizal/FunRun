package com.funrun.controller.commands
{
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.Messages;
	import com.funrun.services.MatchmakingService;
	
	import org.robotlegs.mvcs.Command;
	
	public class SendMatchmakingReadyCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Services.
		
		[Inject]
		public var matchmakingService:MatchmakingService;
		
		override public function execute():void
		{
			matchmakingService.send( Messages.READY, playerModel.inGameId );
		}
	}
}