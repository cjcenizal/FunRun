package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.model.state.LoginState;
	import org.robotlegs.mvcs.Command;

	public class LoginFailedCommand extends Command {
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		override public function execute():void {
			updateLoginStatus.dispatch( LoginState.PLAYERIO_FAILURE );
		}
	}
}
