package com.funrun.controller.commands {

	import com.funrun.services.IWhitelistService;

	import org.robotlegs.mvcs.Command;

	public class BuildWhitelistCommand extends Command {

		[Inject]
		public var whitelistService:IWhitelistService;

		override public function execute():void {
			whitelistService.add( 2511953 ); 			// CJ
			whitelistService.add( 100001085609205 ); 	// Joe's fake account
			whitelistService.add( 2534037 ); 			// Ben
			whitelistService.add( 2508688 ); 			// Damien
			whitelistService.add( 576378792 ); 			// Chris Benjaminsen
			whitelistService.add( 753448770 );			// Ian
			whitelistService.add( 2515405 );			// Groves
			whitelistService.add( 2501150 );			// Kim Pham
		}
	}
}
