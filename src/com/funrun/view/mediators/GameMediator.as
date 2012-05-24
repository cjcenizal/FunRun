package com.funrun.view.mediators {

	import com.funrun.controller.events.InternalShowMainMenuRequest;
	import com.funrun.controller.events.StartRunningGameRequest;
	import com.funrun.controller.events.StopRunningGameRequest;
	import com.funrun.view.components.GameView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class GameMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:GameView;
		
		override public function onRegister():void {
			view.build();

			// Listen for external module events.
			//moduleCommandMap.mapEvent( ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED, ExternalShowGameModuleCommand, ExternalShowGameModuleRequest );

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
			//moduleDispatcher.dispatchEvent( new ExternalShowMainMenuModuleRequest( ExternalShowMainMenuModuleRequest.EXTERNAL_SHOW_MAIN_MENU_MODULE_REQUESTED ) );
		}
	}
}
