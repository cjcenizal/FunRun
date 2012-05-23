package com.funrun.modulemanager.controller.commands {
	
	import com.facebook.graph.Facebook;
	import com.funrun.modulemanager.model.ConfigurationModel;
	import com.funrun.modulemanager.services.PlayerioFacebookLoginService;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoginCommand extends Command {
		
		[Inject]
		public var configurationModel:ConfigurationModel;
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		override public function execute():void {
			loginService.onConnectedSignal.add( onConnected );
			loginService.onErrorSignal.add( onError );
			loginService.connect( this.contextView.stage, configurationModel.fbAccessToken, configurationModel.playerioGameId, configurationModel.playerioPartnerId );
			
			/*
			//If played on facebook
			if(parameters.fb_access_token){
				//Connect in the background
				PlayerIO.quickConnect.facebookOAuthConnect(stage, gameid, parameters.fb_access_token, null, function(c:Client, id:String=""):void{
					handleConnect(c, parameters.fb_access_token, id)
				}, handleError);
			}else{
				//Else we are in development, connect with a facebook popup
				PlayerIO.quickConnect.facebookOAuthConnectPopup(
					stage,
					gameid,
					"_blank",
					[],
					null,						//Current PartnerPay partner.
					handleConnect, 
					handleError
				);
			}
			*/
			// Get FB access token.
			// Connect to playerIO with token.
			// Initialize user account if new.
				// Get FB graph data.
			//loginService.connect( stage,
		}
		
		private function onConnected():void {
			trace(this, "connected");
			Facebook.init( configurationModel.fbAppId, this.onFacebookInit, null, configurationModel.fbAccessToken );
		}
		
		private function onFacebookInit(success:Object, fail:Object):void {
			trace("init");
			/*
			// Init the AS3 Facebook Graph API.
			FB.init( { access_token: configurationModel.fbAccessToken, app_id: configurationModel.fbAppId, debug: true } );
			
			FB.subscribe('auth.login', function() {
				// Get user data.
				FB.api( '/me', function( response:* ):void {
					//_me = response;
					//_gender = _me[ "gender" ];
					//_name = _me[ "name" ];
					//_firstName = _me[ "first_name" ];
					trace(response);
				} );
			} );*/
		}
		
		private function onError():void {
			trace(this, "error");
		}
	}
}
