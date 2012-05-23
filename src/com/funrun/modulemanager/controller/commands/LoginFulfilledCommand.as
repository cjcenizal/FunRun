package com.funrun.modulemanager.controller.commands {

	import org.robotlegs.mvcs.Command;

	public class LoginFulfilledCommand extends Command {
		
		override public function execute():void {
			trace(this, "Whitelist fulfilled.");
		}
	}
}
