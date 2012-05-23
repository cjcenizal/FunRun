package com.funrun.mainmenu {
	
	import com.funrun.mainmenu.controller.commands.ExternalShowGameModuleCommand;
	import com.funrun.mainmenu.controller.commands.ExternalShowMainMenuCommand;
	import com.funrun.mainmenu.controller.commands.ExternalToggleMainMenuOptionsCommand;
	import com.funrun.mainmenu.controller.signals.DisableMainMenuOptionsRequest;
	import com.funrun.mainmenu.controller.signals.EnableMainMenuOptionsRequest;
	import com.funrun.mainmenu.controller.signals.StartRunningMainMenuRequest;
	import com.funrun.mainmenu.controller.signals.StopRunningMainMenuRequest;
	import com.funrun.modulemanager.controller.events.ExternalShowGameModuleRequest;
	import com.funrun.modulemanager.controller.events.ExternalShowMainMenuModuleRequest;
	import com.funrun.modulemanager.controller.events.ExternalToggleMainMenuOptionsRequest;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	
	public class MainMenuMediator extends ModuleMediator {
		
		[Inject]
		public var view:MainMenuModule;
		
		[Inject]
		public var stopRunningMainMenu:StopRunningMainMenuRequest;
		
		[Inject]
		public var startRunningMainMenu:StartRunningMainMenuRequest;
		
		[Inject]
		public var enableMainMenuOptions:EnableMainMenuOptionsRequest
		
		[Inject]
		public var disableMainMenuOptions:DisableMainMenuOptionsRequest;
		
		override public function onRegister():void {
			// Build our view.
			view.build();
			
			// Listen for inter-module events.
			moduleCommandMap.mapEvent( ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED, 					ExternalShowGameModuleCommand, 				ExternalShowGameModuleRequest );
			moduleCommandMap.mapEvent( ExternalShowMainMenuModuleRequest.EXTERNAL_SHOW_MAIN_MENU_MODULE_REQUESTED,			ExternalShowMainMenuCommand, 				ExternalShowMainMenuModuleRequest );
			moduleCommandMap.mapEvent( ExternalToggleMainMenuOptionsRequest.EXTERNAL_TOGGLE_MAIN_MENU_OPTIONS_REQUESTED,	ExternalToggleMainMenuOptionsCommand, 		ExternalToggleMainMenuOptionsRequest );
			
			// Listen for intra-module events.
			stopRunningMainMenu.add( onStopRunningMainMenuRequested );
			startRunningMainMenu.add( onStartRunningMainMenuRequested );
			enableMainMenuOptions.add( onEnableMainMenuOptionsRequested );
			disableMainMenuOptions.add( onDisableMainMenuOptionsRequested );
			
			// Listen for view events.
			view.onStartGameButtonClick.add( onStartGameButtonClick );
		}
		
		private function onStartRunningMainMenuRequested():void {
			view.startRunning();
		}
		
		private function onStopRunningMainMenuRequested():void {
			view.stopRunning();
		}
		
		private function onEnableMainMenuOptionsRequested():void {
			view.optionsEnabled = true;
		}
		
		private function onDisableMainMenuOptionsRequested():void {
			view.optionsEnabled = false;
		}
		
		private function onStartGameButtonClick():void {
			moduleDispatcher.dispatchEvent( new ExternalShowGameModuleRequest( ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED ) );
		}
		
	}
}
