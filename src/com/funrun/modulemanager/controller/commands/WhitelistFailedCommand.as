package com.funrun.modulemanager.controller.commands
{
	import org.robotlegs.mvcs.Command;
	import com.funrun.modulemanager.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.modulemanager.model.state.LoginState;
	
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