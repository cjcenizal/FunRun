package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.model.state.LoginState;
	
	import org.robotlegs.mvcs.Command;

	public class LoginFulfilledCommand extends Command {
		
		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		override public function execute():void {
			updateLoginStatus.dispatch( LoginState.LOGIN_SUCCESS );
			enableMainMenuRequest.dispatch( true );
		}
	}
}
