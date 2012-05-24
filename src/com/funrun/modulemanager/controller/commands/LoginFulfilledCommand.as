package com.funrun.modulemanager.controller.commands {
	
	import com.funrun.modulemanager.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.modulemanager.model.state.LoginState;
	import com.funrun.modulemanager.controller.signals.ToggleMainMenuOptionsRequest;
	import com.funrun.modulemanager.controller.signals.payloads.ToggleMainMenuOptionsPayload;
	
	import org.robotlegs.mvcs.Command;

	public class LoginFulfilledCommand extends Command {
		
		[Inject]
		public var toggleMainModuleRequest:ToggleMainMenuOptionsRequest;
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		override public function execute():void {
			updateLoginStatus.dispatch( LoginState.LOGIN_SUCCESS );
			toggleMainModuleRequest.dispatch( new ToggleMainMenuOptionsPayload( true ) );
		}
	}
}
