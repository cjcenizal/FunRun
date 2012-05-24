package com.funrun.modulemanager.controller.commands {
	
	import com.funrun.modulemanager.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.modulemanager.model.state.LoginState;
	import org.robotlegs.mvcs.Command;

	public class LoginFailedCommand extends Command {
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		override public function execute():void {
			updateLoginStatus.dispatch( LoginState.PLAYERIO_FAILURE );
		}
	}
}
