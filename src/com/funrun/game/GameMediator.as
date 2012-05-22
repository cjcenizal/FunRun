package com.funrun.game {
	
	import com.funrun.game.controller.commands.ExternalShowGameModuleCommand;
	import com.funrun.game.controller.events.InternalShowMainMenuRequest;
	import com.funrun.game.controller.events.StartRunningGameRequest;
	import com.funrun.game.controller.events.StopRunningGameRequest;
	import com.funrun.modulemanager.controller.events.ExternalShowGameModuleRequest;
	import com.funrun.modulemanager.controller.events.ExternalShowMainMenuModuleRequest;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	
	public class GameMediator extends ModuleMediator {
		
		[Inject]
		public var view:GameModule;
		
		override public function onRegister():void {
			view.build();
			
			// Listen for external module events.
			moduleCommandMap.mapEvent( ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED, ExternalShowGameModuleCommand, ExternalShowGameModuleRequest );
			
			// Internal event listeners.
			eventDispatcher.addEventListener( StartRunningGameRequest.START_RUNNING_GAME_REQUESTED, onStartRunningGameRequested );
			eventDispatcher.addEventListener( StopRunningGameRequest.STOP_RUNNING_GAME_REQUEST, onStopRunningGameRequested );
			eventDispatcher.addEventListener( InternalShowMainMenuRequest.INTERNAL_SHOW_MAIN_MENU_REQUESTED, onInternalShowMainMenuRequested );
		}
		
		private function onStartRunningGameRequested( e:StartRunningGameRequest ):void {
			view.startRunning();
		}
		
		private function onStopRunningGameRequested( e:StopRunningGameRequest ):void {
			view.stopRunning();
		}
		
		private function onInternalShowMainMenuRequested( e:InternalShowMainMenuRequest ):void {
			moduleDispatcher.dispatchEvent( new ExternalShowMainMenuModuleRequest( ExternalShowMainMenuModuleRequest.EXTERNAL_SHOW_MAIN_MENU_MODULE_REQUESTED ) );
		}
	}
}
