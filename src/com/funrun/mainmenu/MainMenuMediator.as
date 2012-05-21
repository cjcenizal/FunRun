package com.funrun.mainmenu {
	
	import com.funrun.mainmenu.controller.commands.ExternalShowMainMenuCommand;
	import com.funrun.mainmenu.controller.commands.ExternalShowGameModuleCommand;
	import com.funrun.mainmenu.controller.events.StartRunningMainMenuRequest;
	import com.funrun.mainmenu.controller.events.StopRunningMainMenuRequest;
	import com.funrun.modulemanager.events.ExternalShowGameModuleRequest;
	import com.funrun.modulemanager.events.ExternalShowMainMenuModuleRequest;
	
	import flash.events.Event;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	
	public class MainMenuMediator extends ModuleMediator {
		
		[Inject]
		public var view:MainMenuModule;
		
		override public function onRegister():void {
			// Build our view.
			view.build();
			
			// Listen for inter-module events.
			moduleCommandMap.mapEvent( ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED, 				ExternalShowGameModuleCommand, 					ExternalShowGameModuleRequest );
			moduleCommandMap.mapEvent( ExternalShowMainMenuModuleRequest.EXTERNAL_SHOW_MAIN_MENU_MODULE_REQUESTED,		ExternalShowMainMenuCommand, 		ExternalShowMainMenuModuleRequest );
			
			// Listen for intra-module events.
			eventDispatcher.addEventListener( StopRunningMainMenuRequest.STOP_RUNNING_MAIN_MENU_REQUESTED, onStopRunningMainMenuRequested );
			eventDispatcher.addEventListener( StartRunningMainMenuRequest.START_RUNNING_MAIN_MENU_REQUESTED, onStartRunningMainMenuRequested );
			
			// Listen for view events.
			view.onStartGameButtonClick.add( onStartGameButtonClick );
			
			// Show our view a frame after it's added.
			view.addEventListener( Event.ENTER_FRAME, onEnter );
		}
		
		private function onEnter( e:Event ):void {
			view.removeEventListener( Event.ENTER_FRAME, onEnter );
			view.startRunning();
		}
		
		private function onStartRunningMainMenuRequested( e:StartRunningMainMenuRequest ):void {
			view.startRunning();
		}
		
		private function onStopRunningMainMenuRequested( e:StopRunningMainMenuRequest ):void {
			view.stopRunning();
		}
		
		private function onStartGameButtonClick():void {
			moduleDispatcher.dispatchEvent( new ExternalShowGameModuleRequest( ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED ) );
		}
		
	}
}
