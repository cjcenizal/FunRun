package com.funrun.modulemanager.controller.commands {
	
	import com.funrun.modulemanager.model.ConfigurationModel;
	
	import flash.display.LoaderInfo;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadConfigurationCommand extends Command {
		
		[Inject]
		public var configurationModel:ConfigurationModel;
		
		override public function execute():void {
			trace("config");
			var parameters:Object = LoaderInfo( this.contextView.root.loaderInfo ).parameters;
			configurationModel.playerioGameId = parameters.sitebox_gameid;
			configurationModel.fbAppId = parameters.fb_application_id;
			configurationModel.fbAccessToken = parameters.fb_access_token;
		}
	}
}
