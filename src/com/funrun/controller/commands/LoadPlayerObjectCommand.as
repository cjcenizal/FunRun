package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.PlayerioPlayerObjectService;
	
	import org.robotlegs.mvcs.Command;

	public class LoadPlayerObjectCommand extends Command {
		
		[Inject]
		public var playerioLoginService:PlayerioFacebookLoginService;
		
		[Inject]
		public var playerObjectService:PlayerioPlayerObjectService;
		
		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;

		override public function execute():void {
			playerObjectService.onLoadedSignal.add( onLoaded );
			playerObjectService.onErrorSignal.add( onError );
			playerObjectService.load( playerioLoginService.client );
		}
		
		private function onLoaded():void {
			trace(this, "onLoaded");
			enableMainMenuRequest.dispatch( true );
		}
		
		private function onError():void {
			trace(this, "onError");
		}
	}
}
