package com.funrun.controller.commands {

	import com.funrun.controller.signals.CompleteAppRequest;
	import com.funrun.model.state.LoginState;

	import org.robotlegs.mvcs.Command;

	public class CompleteUserCommand extends Command {

		[Inject]
		public var completeAppRequest:CompleteAppRequest;

		override public function execute():void {
			LoginState.isComplete = true;
			completeAppRequest.dispatch();
		}
	}
}
