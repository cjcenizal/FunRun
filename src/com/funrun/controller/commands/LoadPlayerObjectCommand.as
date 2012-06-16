package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.PlayerioPlayerObjectService;
	
	import org.robotlegs.mvcs.Command;

	public class LoadPlayerObjectCommand extends Command {
		
		// Services.
		
		[Inject]
		public var playerioFacebookLoginService:PlayerioFacebookLoginService;
		
		[Inject]
		public var playerioPlayerObjectService:PlayerioPlayerObjectService;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		
		override public function execute():void {
			playerioPlayerObjectService.onLoadedSignal.add( onLoaded );
			playerioPlayerObjectService.onErrorSignal.add( onError );
			playerioPlayerObjectService.load( playerioFacebookLoginService.client );
		}
		
		private function onLoaded():void {
			trace(this, "onLoaded");
			
			
			// Assign the player object to the model.
			
			
			enableMainMenuRequest.dispatch( true );
		}
		
		private function onError():void {
			trace(this, "onError");
		}
	}
}
