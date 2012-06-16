package com.funrun.controller.commands {
	
	import Facebook.FB;
	
	import com.funrun.controller.signals.CheckWhitelistRequest;
	import com.funrun.controller.signals.LoginFailed;
	import com.funrun.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.model.ConfigurationModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.state.LoginState;
	import com.funrun.services.PlayerioFacebookLoginService;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoginCommand extends Command {
		
		// Models.
		
		[Inject]
		public var configurationModel:ConfigurationModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Services.
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		// Commands.
		
		[Inject]
		public var loginFailed:LoginFailed;
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		[Inject]
		public var checkWhitelistRequest:CheckWhitelistRequest;
		
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
				playerModel.name = response.name;
				playerModel.userId = response.id;
				checkWhitelistRequest.dispatch();
			} );
		}
		
		private function onError():void {
			loginFailed.dispatch();
		}
	}
}
