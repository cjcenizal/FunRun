package com.funrun.modulemanager.controller.commands {

	import com.funrun.modulemanager.services.IWhitelistService;

	import org.robotlegs.mvcs.Command;

	public class BuildWhitelistCommand extends Command {

		[Inject]
		public var whitelistService:IWhitelistService;

		override public function execute():void {
		}
	}
}
