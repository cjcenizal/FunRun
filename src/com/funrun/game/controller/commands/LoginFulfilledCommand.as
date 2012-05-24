package com.funrun.game.controller.commands {
	
	import com.funrun.game.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.game.model.state.LoginState;
	import com.funrun.game.controller.signals.ToggleMainMenuOptionsRequest;
	import com.funrun.game.controller.signals.payloads.ToggleMainMenuOptionsPayload;
	
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
