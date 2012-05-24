package com.funrun.view.mediators {

	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.StartRunningMainMenuRequest;
	import com.funrun.controller.signals.StopRunningMainMenuRequest;
	import com.funrun.view.components.MainMenuView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class MainMenuMediator extends Mediator implements IMediator {

		[Inject]
		public var view:MainMenuView;

		[Inject]
		public var stopRunningMainMenu:StopRunningMainMenuRequest;

		[Inject]
		public var startRunningMainMenu:StartRunningMainMenuRequest;

		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		override public function onRegister():void {
			// Build our view.
			view.build();

			// Listen for signals.
			stopRunningMainMenu.add( onStopRunningMainMenuRequested );
			startRunningMainMenu.add( onStartRunningMainMenuRequested );
			enableMainMenuRequest.add( onEnableMainMenuRequested );
			// Listen for view events.
			//view.onStartGameButtonClick.add( onStartGameButtonClick );
		}

		private function onStartRunningMainMenuRequested():void {
			view.startRunning();
		}

		private function onStopRunningMainMenuRequested():void {
			view.stopRunning();
		}

		private function onEnableMainMenuRequested( enabled:Boolean ):void {
			view.optionsEnabled = enabled;
		}

		private function onStartGameButtonClick():void {
			//moduleDispatcher.dispatchEvent( new ExternalShowGameModuleRequest( ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED ) );
		}

	}
}
