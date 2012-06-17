package com.funrun.controller.commands {

	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.InitGameRequest;
	import com.funrun.controller.signals.LoadConfigurationRequest;
	import com.funrun.controller.signals.LoginRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.state.OnlineState;
	import com.funrun.model.state.ScreenState;
	
	import org.robotlegs.mvcs.Command;

	public class InitAppCommand extends Command {

		// State.
		
		[Inject]
		public var onlineState:OnlineState;
		
		// Commands.
		
		[Inject]
		public var loadConfigurationRequest:LoadConfigurationRequest;
		
		[Inject]
		public var loginRequest:LoginRequest;
		
		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		[Inject]
		public var toggleMainModuleRequest:EnableMainMenuRequest;
		
		[Inject]
		public var initGameRequest:InitGameRequest;
		
		override public function execute():void {
			// Update view.
			showScreenRequest.dispatch( ScreenState.MAIN_MENU );
			toggleMainModuleRequest.dispatch( false );
			// Build everyhing.
			initGameRequest.dispatch();
			// Configure the app and login.
			loadConfigurationRequest.dispatch();
			if ( onlineState.isOnline ) {
				loginRequest.dispatch();
			} else {
				enableMainMenuRequest.dispatch( true );
			}
		}
	}
}
