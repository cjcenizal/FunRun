package com.funrun.game.controller.commands {
	
	import com.funrun.game.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.game.model.state.LoginState;
	import org.robotlegs.mvcs.Command;

	public class LoginFailedCommand extends Command {
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		override public function execute():void {
			updateLoginStatus.dispatch( LoginState.PLAYERIO_FAILURE );
		}
	}
}
