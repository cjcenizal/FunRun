package com.funrun.game {
	
	import com.funrun.game.controller.commands.StartGameCommand;
	import com.funrun.game.controller.events.ExitGameRequest;
	import com.funrun.game.controller.events.StartRunningGameRequest;
	import com.funrun.modulemanager.events.ReturnToMainMenuRequest;
	import com.funrun.modulemanager.events.StartGameRequest;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	
	public class GameMediator extends ModuleMediator {
		
		[Inject]
		public var view:GameModule;
		
		override public function onRegister():void {
			view.build();
			moduleCommandMap.mapEvent( StartGameRequest.START_GAME_REQUESTED, StartGameCommand, StartGameRequest );
			eventDispatcher.addEventListener( StartRunningGameRequest.START_RUNNING_GAME_REQUESTED, onStartRunningGameRequested );
			eventDispatcher.addEventListener( ExitGameRequest.EXIT_GAME_REQUESTED, onExitGameRequested );
		}
		
		private function onStartRunningGameRequested( e:StartRunningGameRequest ):void {
			view.startRunning();
		}
		
		private function onExitGameRequested( e:ExitGameRequest ):void {
			view.stopRunning();
			moduleDispatcher.dispatchEvent( new ReturnToMainMenuRequest( ReturnToMainMenuRequest.RETURN_TO_MAIN_MENU_REQUESTED ) );
		}
	}
}
