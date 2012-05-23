package com.funrun.modulemanager.controller.commands {

	import org.robotlegs.mvcs.Command;

	public class LoginFailedCommand extends Command {
		
		override public function execute():void {
			// TO-DO: Display error feedback.
			trace(this, "Login error!");
		}
	}
}
