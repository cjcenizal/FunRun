package com.funrun.game.controller.commands {

	import com.funrun.game.controller.signals.BuildWhitelistRequest;
	import com.funrun.game.controller.signals.LoadConfigurationRequest;
	import com.funrun.game.controller.signals.LoginRequest;
	import com.funrun.game.controller.signals.ShowMainModuleRequest;
	import com.funrun.game.controller.signals.ToggleMainMenuOptionsRequest;
	import com.funrun.game.controller.signals.payloads.ToggleMainMenuOptionsPayload;
	
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
			toggleMainModuleRequest.dispatch( new ToggleMainMenuOptionsPayload( false ) );
		}
	}
}
