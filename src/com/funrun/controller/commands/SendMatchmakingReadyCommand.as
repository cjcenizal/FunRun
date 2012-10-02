package com.funrun.controller.commands
{
	import com.funrun.services.MatchmakingService;
	import com.funrun.model.constants.Messages;
	import com.funrun.model.state.OnlineState;
	
	import org.robotlegs.mvcs.Command;
	
	public class SendMatchmakingReadyCommand extends Command
	{
		
		// State.
		
		[Inject]
		public var onlineState:OnlineState;
		
		// Services.
		
		[Inject]
		public var matchmakingService:MatchmakingService;
		
		override public function execute():void
		{
			
		}
	}
}