package com.funrun.controller.commands {

	import com.funrun.controller.signals.BuildGameRequest;
	import com.funrun.controller.signals.BuildInterpolationRequest;
	import com.funrun.controller.signals.BuildTimeRequest;
	import com.funrun.controller.signals.BuildWhitelistRequest;
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.LoadConfigurationRequest;
	import com.funrun.controller.signals.LoginRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.state.ScreenState;
	
	import org.robotlegs.mvcs.Command;

	public class InitAppCommand extends Command {

		[Inject]
		public var buildWhitelistRequest:BuildWhitelistRequest;
		
		[Inject]
		public var loadConfigurationRequest:LoadConfigurationRequest;
		
		[Inject]
		public var loginRequest:LoginRequest;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		[Inject]
		public var toggleMainModuleRequest:EnableMainMenuRequest;
		
		[Inject]
		public var buildInterpolationRequest:BuildInterpolationRequest;
		
		[Inject]
		public var buildTimeRequest:BuildTimeRequest;
		
		[Inject]
		public var buildGameRequest:BuildGameRequest;
		
		override public function execute():void {
			// Update view.
			showScreenRequest.dispatch( ScreenState.MAIN_MENU );
			toggleMainModuleRequest.dispatch( false );
			// Build everyhing.
			buildInterpolationRequest.dispatch();
			buildTimeRequest.dispatch();
			buildGameRequest.dispatch();
			buildWhitelistRequest.dispatch();
			// Configure the app and login.
			loadConfigurationRequest.dispatch();
			loginRequest.dispatch();
		}
	}
}
