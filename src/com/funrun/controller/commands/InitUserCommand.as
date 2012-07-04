package com.funrun.controller.commands {

	import com.funrun.controller.signals.CompleteUserRequest;
	import com.funrun.controller.signals.LoadConfigurationRequest;
	import com.funrun.controller.signals.LoginRequest;
	import com.funrun.model.state.OnlineState;
	
	import org.robotlegs.mvcs.Command;

	public class InitUserCommand extends Command {

		// State.

		[Inject]
		public var onlineState:OnlineState;

		// Commands.

		[Inject]
		public var loadConfigurationRequest:LoadConfigurationRequest;

		[Inject]
		public var loginRequest:LoginRequest;
		
		[Inject]
		public var completeUserRequest:CompleteUserRequest;

		override public function execute():void {
			// Configure the app and login.
			loadConfigurationRequest.dispatch();
			if ( onlineState.isOnline ) {
				loginRequest.dispatch();
			} else {
				completeUserRequest.dispatch();
			}
		}
	}
}
