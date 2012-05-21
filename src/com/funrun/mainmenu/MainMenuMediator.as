package com.funrun.mainmenu {
	
	import com.funrun.mainmenu.controller.commands.ReturnToMainMenuCommand;
	import com.funrun.mainmenu.controller.commands.StartGameCommand;
	import com.funrun.mainmenu.controller.events.StartRunningMainMenuRequest;
	import com.funrun.mainmenu.controller.events.StopRunningMainMenuRequest;
	import com.funrun.modulemanager.events.ReturnToMainMenuRequest;
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
			moduleCommandMap.mapEvent( StartGameRequest.START_GAME_REQUESTED, 						StartGameCommand, 					StartGameRequest );
			moduleCommandMap.mapEvent( ReturnToMainMenuRequest.RETURN_TO_MAIN_MENU_REQUESTED,		ReturnToMainMenuCommand, 		ReturnToMainMenuRequest );
			
			// Listen for intra-module events.
			eventDispatcher.addEventListener( StopRunningMainMenuRequest.STOP_RUNNING_MAIN_MENU_REQUESTED, onStopMainMenuRequested );
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
		
		private function onStartGameButtonClick():void {
			moduleDispatcher.dispatchEvent( new StartGameRequest( StartGameRequest.START_GAME_REQUESTED ) );
		}
		
		private function onStopMainMenuRequested( e:StopRunningMainMenuRequest ):void {
			view.stopRunning();
		}
		
	}
}
