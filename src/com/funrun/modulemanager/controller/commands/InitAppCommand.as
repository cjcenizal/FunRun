package com.funrun.modulemanager.controller.commands {

	import com.funrun.modulemanager.controller.signals.BuildWhitelistRequest;
	import com.funrun.modulemanager.controller.signals.LoadConfigurationRequest;
	import com.funrun.modulemanager.controller.signals.LoginRequest;
	import com.funrun.modulemanager.controller.signals.ShowMainModuleRequest;
	import com.funrun.modulemanager.controller.signals.ToggleMainMenuOptionsRequest;
	import com.funrun.modulemanager.controller.signals.payloads.ToggleMainMenuOptionsPayload;
	
	import org.robotlegs.mvcs.Command;

	public class InitAppCommand extends Command {

		[Inject]
		public var buildWhitelistRequest:BuildWhitelistRequest;
		
		[Inject]
		public var loadConfigurationRequest:LoadConfigurationRequest;
		
		[Inject]
		public var loginRequest:LoginRequest;
		
		[Inject]
		public var showMainModuleRequest:ShowMainModuleRequest;
		
		[Inject]
		public var toggleMainModuleRequest:ToggleMainMenuOptionsRequest;
		
		override public function execute():void {
			buildWhitelistRequest.dispatch();
			loadConfigurationRequest.dispatch();
			loginRequest.dispatch();
			showMainModuleRequest.dispatch();
			toggleMainModuleRequest.dispatch( new ToggleMainMenuOptionsPayload( true ) );
		}
	}
}
