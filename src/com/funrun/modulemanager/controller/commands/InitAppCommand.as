package com.funrun.modulemanager.controller.commands {

	import com.funrun.modulemanager.controller.signals.LoadConfigurationRequestSignal;
	import com.funrun.modulemanager.controller.signals.LoginRequestSignal;
	import com.funrun.modulemanager.controller.signals.ShowMainModuleRequestSignal;
	import com.funrun.modulemanager.controller.signals.ToggleMainMenuOptionsRequestSignal;
	import com.funrun.modulemanager.controller.signals.payloads.ToggleMainMenuOptionsRequestPayload;
	
	import org.robotlegs.mvcs.Command;

	public class InitAppCommand extends Command {

		[Inject]
		public var loadConfigurationRequest:LoadConfigurationRequestSignal;
		
		[Inject]
		public var loginRequest:LoginRequestSignal;
		
		[Inject]
		public var showMainModuleRequest:ShowMainModuleRequestSignal;
		
		[Inject]
		public var toggleMainModuleRequest:ToggleMainMenuOptionsRequestSignal;
		
		override public function execute():void {
			loadConfigurationRequest.dispatch();
			loginRequest.dispatch();
			showMainModuleRequest.dispatch();
			toggleMainModuleRequest.dispatch( new ToggleMainMenuOptionsRequestPayload( false ) );
		}
	}
}
