package com.funrun.game.controller.commands {

	import com.funrun.game.services.IWhitelistService;

	import org.robotlegs.mvcs.Command;

	public class BuildWhitelistCommand extends Command {

		[Inject]
		public var whitelistService:IWhitelistService;

		override public function execute():void {
			whitelistService.add( "2511953" ); // CJ
		}
	}
}
