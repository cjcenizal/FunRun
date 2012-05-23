package com.funrun.modulemanager.controller.commands {

	import com.funrun.modulemanager.controller.signals.LoadConfigurationRequest;
	import com.funrun.modulemanager.controller.signals.LoginRequest;
	import com.funrun.modulemanager.controller.signals.ShowMainModuleRequest;
	import com.funrun.modulemanager.controller.signals.ToggleMainMenuOptionsRequest;
	import com.funrun.modulemanager.controller.signals.payloads.ToggleMainMenuOptionsRequestPayload;
	
	import org.robotlegs.mvcs.Command;

	public class InitAppCommand extends Command {

		[Inject]
		public var loadConfigurationRequest:LoadConfigurationRequest;
		
		[Inject]
		public var loginRequest:LoginRequest;
		
		[Inject]
		public var showMainModuleRequest:ShowMainModuleRequest;
		
		[Inject]
		public var toggleMainModuleRequest:ToggleMainMenuOptionsRequest;
		
		override public function execute():void {
			loadConfigurationRequest.dispatch();
			loginRequest.dispatch();
			showMainModuleRequest.dispatch();
			toggleMainModuleRequest.dispatch( new ToggleMainMenuOptionsRequestPayload( true ) );
		}
	}
}
