package com.funrun.controller.commands {

	import com.funrun.controller.signals.BuildGameRequest;
	import com.funrun.controller.signals.BuildInterpolationRequest;
	import com.funrun.controller.signals.BuildTimeRequest;
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.LoadConfigurationRequest;
	import com.funrun.controller.signals.LoginFulfilled;
	import com.funrun.controller.signals.LoginRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.state.OnlineState;
	import com.funrun.model.state.ScreenState;
	import com.funrun.services.IWhitelistService;
	
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
		public var loginFulfilled:LoginFulfilled;
		
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
		
		// Services.
		
		[Inject]
		public var whitelistService:IWhitelistService;
		
		override public function execute():void {
			// Load whitelist.
			whitelistService.load();
			// Update view.
			showScreenRequest.dispatch( ScreenState.MAIN_MENU );
			toggleMainModuleRequest.dispatch( false );
			// Build everyhing.
			buildInterpolationRequest.dispatch();
			buildTimeRequest.dispatch();
			buildGameRequest.dispatch();
			// Configure the app and login.
			loadConfigurationRequest.dispatch();
			if ( onlineState.isOnline ) {
				if ( whitelistService.isLoaded ) {
					loginRequest.dispatch();
				} else {
					whitelistService.onLoadedSignal.add( onWhitelistLoaded );
				}
			} else {
				loginFulfilled.dispatch();
			}
		}
		
		private function onWhitelistLoaded():void {
			whitelistService.onLoadedSignal.remove( onWhitelistLoaded );
			loginRequest.dispatch();
		}
	}
}
