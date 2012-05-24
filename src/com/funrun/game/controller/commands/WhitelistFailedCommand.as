package com.funrun.game.controller.commands
{
	import org.robotlegs.mvcs.Command;
	import com.funrun.game.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.game.model.state.LoginState;
	
	public class WhitelistFailedCommand extends Command
	{
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		override public function execute():void
		{
			updateLoginStatus.dispatch( LoginState.WHITELIST_FAILURE );
		}
	}
}