package com.funrun.mainmenu {
	
	import com.funrun.mainmenu.controller.commands.StartGameCommand;
	import com.funrun.mainmenu.controller.events.StopRunningMainMenuRequest;
	import com.funrun.modulemanager.events.StartGameRequest;
	
	import flash.events.Event;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	
	public class MainMenuMediator extends ModuleMediator {
		
		[Inject]
		public var view:MainMenuModule;
		
		override public function onRegister():void {
			// Build our view.
			view.build();
			
			// Listen for inter-module events.
			moduleCommandMap.mapEvent( StartGameRequest.START_GAME_REQUESTED, StartGameCommand, StartGameRequest );
			
			// Listen for intra-module events.
			eventDispatcher.addEventListener( StopRunningMainMenuRequest.STOP_RUNNING_MAIN_MENU_REQUESTED, onStopMainMenuRequested );
			
			// Listen for view events.
			view.addEventListener( "CLICK", onClick );
			
			// Show our view.
			view.startRunning();
		}
		
		private function onClick( e:Event ):void {
			moduleDispatcher.dispatchEvent( new StartGameRequest( StartGameRequest.START_GAME_REQUESTED ) );
		}
		
		private function onStopMainMenuRequested( e:StopRunningMainMenuRequest ):void {
			view.stopRunning();
		}
		
	}
}
