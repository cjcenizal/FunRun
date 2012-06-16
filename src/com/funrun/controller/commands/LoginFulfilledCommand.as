package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.LoadPlayerObjectRequest;
	import com.funrun.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.model.state.LoginState;
	
	import org.robotlegs.mvcs.Command;

	public class LoginFulfilledCommand extends Command {
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		[Inject]
		public var loadPlayerObjectRequest:LoadPlayerObjectRequest;
		
		override public function execute():void {
			updateLoginStatus.dispatch( LoginState.LOGIN_SUCCESS );
			loadPlayerObjectRequest.dispatch();
		}
	}
}
