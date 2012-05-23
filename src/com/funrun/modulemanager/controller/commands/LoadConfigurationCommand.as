package com.funrun.modulemanager.controller.commands {
	
	import com.funrun.modulemanager.model.ConfigurationModel;
	
	import flash.display.LoaderInfo;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadConfigurationCommand extends Command {
		
		[Inject]
		public var configurationModel:ConfigurationModel;
		
		override public function execute():void {
			var parameters:Object = LoaderInfo( this.contextView.root.loaderInfo ).parameters;
			configurationModel.playerioGameId = "funrun-wzswxfkte6ikptb5fqehw";//parameters.sitebox_gameid;
			configurationModel.fbAppId = "392243894148756";//parameters.fb_application_id;
			configurationModel.fbAccessToken = parameters.fb_access_token;
		}
	}
}
