package com.funrun.mainmenu {
	
	import com.funrun.mainmenu.controller.commands.ExternalShowGameModuleCommand;
	import com.funrun.mainmenu.controller.commands.ExternalShowMainMenuCommand;
	import com.funrun.mainmenu.controller.commands.ExternalToggleMainMenuOptionsCommand;
	import com.funrun.mainmenu.controller.events.StartRunningMainMenuRequest;
	import com.funrun.mainmenu.controller.events.StopRunningMainMenuRequest;
	import com.funrun.mainmenu.controller.events.ToggleMainMenuOptionsRequest;
	import com.funrun.modulemanager.controller.events.ExternalShowGameModuleRequest;
	import com.funrun.modulemanager.controller.events.ExternalShowMainMenuModuleRequest;
	import com.funrun.modulemanager.controller.events.ExternalToggleMainMenuOptionsRequest;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	
	public class MainMenuMediator extends ModuleMediator {
		
		[Inject]
		public var view:MainMenuModule;
		
		override public function onRegister():void {
			// Build our view.
			view.build();
			
			// Listen for inter-module events.
			moduleCommandMap.mapEvent( ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED, 					ExternalShowGameModuleCommand, 				ExternalShowGameModuleRequest );
			moduleCommandMap.mapEvent( ExternalShowMainMenuModuleRequest.EXTERNAL_SHOW_MAIN_MENU_MODULE_REQUESTED,			ExternalShowMainMenuCommand, 				ExternalShowMainMenuModuleRequest );
			moduleCommandMap.mapEvent( ExternalToggleMainMenuOptionsRequest.EXTERNAL_TOGGLE_MAIN_MENU_OPTIONS_REQUESTED,	ExternalToggleMainMenuOptionsCommand, 		ExternalToggleMainMenuOptionsRequest );
			
			// Listen for intra-module events.
			eventDispatcher.addEventListener( StopRunningMainMenuRequest.STOP_RUNNING_MAIN_MENU_REQUESTED, onStopRunningMainMenuRequested );
			eventDispatcher.addEventListener( StartRunningMainMenuRequest.START_RUNNING_MAIN_MENU_REQUESTED, onStartRunningMainMenuRequested );
			eventDispatcher.addEventListener( ToggleMainMenuOptionsRequest.TOGGLE_MAIN_MENU_OPTIONS_REQUESTED, onToggleMainMenuOptionsRequested );
			
			// Listen for view events.
			view.onStartGameButtonClick.add( onStartGameButtonClick );
		}
		
		private function onStartRunningMainMenuRequested( e:StartRunningMainMenuRequest ):void {
			view.startRunning();
		}
		
		private function onStopRunningMainMenuRequested( e:StopRunningMainMenuRequest ):void {
			view.stopRunning();
		}
		
		private function onToggleMainMenuOptionsRequested( e:ToggleMainMenuOptionsRequest ):void {
			view.optionsEnabled = e.enabled;
		}
		
		private function onStartGameButtonClick():void {
			moduleDispatcher.dispatchEvent( new ExternalShowGameModuleRequest( ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED ) );
		}
		
	}
}
