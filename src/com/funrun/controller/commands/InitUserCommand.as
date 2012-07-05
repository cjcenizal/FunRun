package com.funrun.controller.commands {

	import Facebook.FB;
	
	import com.funrun.controller.signals.LoadConfigurationRequest;
	import com.funrun.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.model.ConfigurationModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.constants.PlayerProperties;
	import com.funrun.model.state.LoginState;
	import com.funrun.model.state.OnlineState;
	import com.funrun.services.IWhitelistService;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.PlayerioPlayerObjectService;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;

	public class InitUserCommand extends AsyncCommand {

		// State.

		[Inject]
		public var onlineState:OnlineState;
		
		// Models.
		
		[Inject]
		public var configurationModel:ConfigurationModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		[Inject]
		public var loadConfigurationRequest:LoadConfigurationRequest;
		
		// Services.
		
		[Inject]
		public var playerioFacebookLoginService:PlayerioFacebookLoginService;
		
		[Inject]
		public var whitelistService:IWhitelistService;
		
		[Inject]
		public var playerioPlayerObjectService:PlayerioPlayerObjectService;
		
		override public function execute():void {
			// Configure the app and login.
			loadConfigurationRequest.dispatch();
			if ( onlineState.isOnline ) {
				attemptLogin();
			} else {
				dispatchComplete( true );
			}
		}
		
		private function attemptLogin():void {
			updateLoginStatus.dispatch( LoginState.LOGGING_IN );
			playerioFacebookLoginService.onConnectedSignal.add( onLoginConnected );
			playerioFacebookLoginService.onErrorSignal.add( onLoginError );
			playerioFacebookLoginService.connect( this.contextView.stage, configurationModel.fbAccessToken, configurationModel.playerioGameId, configurationModel.playerioPartnerId );
		}
		
		private function onLoginError():void {
			updateLoginStatus.dispatch( LoginState.PLAYERIO_FAILURE );
		}
		
		private function onLoginConnected():void {
			updateLoginStatus.dispatch( LoginState.CONNECTING_TO_FB );
			// If we've received a new token, store it in the model.
			configurationModel.fbAccessToken = playerioFacebookLoginService.fbAccessToken;
			FB.init( { access_token: configurationModel.fbAccessToken, app_id: configurationModel.fbAppId, debug: true } );
			FB.api( '/me', function( response:* ):void {
				// Get user info from Facebook Graph, like their name.
				playerModel.name = response.name;
				playerModel.userId = response.id;
				checkWhitelist();
			} );
		}
		
		private function checkWhitelist():void {
			whitelistService.onPassSignal.add( onWhitelistPassed );
			whitelistService.onFailSignal.add( onWhitelistFailed );
			whitelistService.isIdInTable( playerModel.userId, "Whitelist", playerioFacebookLoginService.client );
		}
		
		private function onWhitelistFailed():void {
			updateLoginStatus.dispatch( LoginState.WHITELIST_FAILURE );
		}
		
		private function onWhitelistPassed():void {
			updateLoginStatus.dispatch( LoginState.LOGIN_SUCCESS );
			playerioPlayerObjectService.onLoadedSignal.add( onPlayerObjectLoaded );
			playerioPlayerObjectService.onErrorSignal.add( onPlayerObjectError );
			playerioPlayerObjectService.connect( playerioFacebookLoginService.client );
		}
		
		private function onPlayerObjectError():void {
			trace(this, "Player Object error");
		}
		
		private function onPlayerObjectLoaded():void {
			trace(this, "Player Object loaded");
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
			dispatchComplete( true );
		}
	}
}
