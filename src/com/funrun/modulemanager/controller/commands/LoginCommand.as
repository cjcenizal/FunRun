package com.funrun.modulemanager.controller.commands {
	
	import com.funrun.modulemanager.model.ConfigurationModel;
	import com.funrun.modulemanager.services.PlayerioFacebookLoginService;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoginCommand extends Command {
		
		[Inject]
		public var loginService:PlayerioFacebookLoginService;
		
		[Inject]
		public var configurationModel:ConfigurationModel;
		
		override public function execute() {
			
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
			}*/
			
			// Get FB access token.
			// Connect to playerIO with token.
			// Initialize user account if new.
				// Get FB graph data.
			//loginService.connect( stage,
		}
	}
}
