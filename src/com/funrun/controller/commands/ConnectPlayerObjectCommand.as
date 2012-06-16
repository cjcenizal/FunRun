package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.PlayerProperties;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.PlayerioPlayerObjectService;
	
	import org.robotlegs.mvcs.Command;

	public class ConnectPlayerObjectCommand extends Command {
		
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
			playerioPlayerObjectService.connect( playerioFacebookLoginService.client );
		}
		
		private function onLoaded():void {
			trace(this, "onLoaded");
			// Read properties from the database.
			var key:String, val:*;
			for ( var i:int = 0; i < PlayerProperties.KEYS.length; i++ ) {
				key = PlayerProperties.KEYS[ i ];
				val = playerioPlayerObjectService.playerObject[ key ];
				if ( !val || val == undefined ) {
					val = PlayerProperties.DEFAULTS[ key ];
				}
				playerModel.properties[ key ] = val;
			}
			enableMainMenuRequest.dispatch( true );
		}
		
		private function onError():void {
			trace(this, "onError");
		}
	}
}
