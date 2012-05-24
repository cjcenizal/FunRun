package com.funrun.modulemanager.controller.commands {
	
	import Facebook.FB;
	
	import com.funrun.modulemanager.controller.signals.LoginFailed;
	import com.funrun.modulemanager.controller.signals.LoginFulfilled;
	import com.funrun.modulemanager.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.modulemanager.controller.signals.WhitelistFailed;
	import com.funrun.modulemanager.model.ConfigurationModel;
	import com.funrun.modulemanager.model.UserModel;
	import com.funrun.modulemanager.services.IWhitelistService;
	import com.funrun.modulemanager.services.PlayerioFacebookLoginService;
	import com.funrun.modulemanager.model.state.LoginState;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoginCommand extends Command {
		
		[Inject]
		public var configurationModel:ConfigurationModel;
		
		[Inject]
		public var userModel:UserModel;
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		[Inject]
		public var loginFulfilled:LoginFulfilled;
		
		[Inject]
		public var loginFailed:LoginFailed;
		
		[Inject]
		public var whitelistService:IWhitelistService;
		
		[Inject]
		public var whitelistFailed:WhitelistFailed;
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		override public function execute():void {
			updateLoginStatus.dispatch( LoginState.LOGGING_IN );
			loginService.onConnectedSignal.add( onConnected );
			loginService.onErrorSignal.add( onError );
			loginService.connect( this.contextView.stage, configurationModel.fbAccessToken, configurationModel.playerioGameId, configurationModel.playerioPartnerId );
		}
		
		private function onConnected():void {
			updateLoginStatus.dispatch( LoginState.CONNECTING_TO_FB );
			// If we've received a new token, store it in the model.
			configurationModel.fbAccessToken = loginService.fbAccessToken;
			FB.init( { access_token: configurationModel.fbAccessToken, app_id: configurationModel.fbAppId, debug: true } );
			FB.api( '/me', function( response:* ):void {
				// Get user info from Facebook Graph, like their name.
				userModel.name = response.name;
				userModel.userId = response.id;
				// Check user id against whitelist.
				if ( whitelistService.passes( userModel.userId ) ) {
					loginFulfilled.dispatch();
				} else {
					whitelistFailed.dispatch();
				}
			} );
		}
		
		private function onError():void {
			loginFailed.dispatch();
		}
	}
}
