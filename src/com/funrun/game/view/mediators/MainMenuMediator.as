package com.funrun.game.view.mediators {

	import com.funrun.game.controller.signals.DisableMainMenuOptionsRequest;
	import com.funrun.game.controller.signals.EnableMainMenuOptionsRequest;
	import com.funrun.game.controller.signals.StartRunningMainMenuRequest;
	import com.funrun.game.controller.signals.StopRunningMainMenuRequest;
	import com.funrun.game.view.components.MainMenuView;

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
		public var enableMainMenuOptions:EnableMainMenuOptionsRequest

		[Inject]
		public var disableMainMenuOptions:DisableMainMenuOptionsRequest;

		override public function onRegister():void {
			// Build our view.
			view.build();

			// Listen for inter-module events.
			//moduleCommandMap.mapEvent( ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED, 					ExternalShowGameModuleCommand, 				ExternalShowGameModuleRequest );
			//moduleCommandMap.mapEvent( ExternalShowMainMenuModuleRequest.EXTERNAL_SHOW_MAIN_MENU_MODULE_REQUESTED,			ExternalShowMainMenuCommand, 				ExternalShowMainMenuModuleRequest );
			//moduleCommandMap.mapEvent( ExternalToggleMainMenuOptionsRequest.EXTERNAL_TOGGLE_MAIN_MENU_OPTIONS_REQUESTED,	ExternalToggleMainMenuOptionsCommand, 		ExternalToggleMainMenuOptionsRequest );

			// Listen for intra-module events.
			stopRunningMainMenu.add( onStopRunningMainMenuRequested );
			startRunningMainMenu.add( onStartRunningMainMenuRequested );
			enableMainMenuOptions.add( onEnableMainMenuOptionsRequested );
			disableMainMenuOptions.add( onDisableMainMenuOptionsRequested );

			// Listen for view events.
			//view.onStartGameButtonClick.add( onStartGameButtonClick );
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
			//moduleDispatcher.dispatchEvent( new ExternalShowGameModuleRequest( ExternalShowGameModuleRequest.EXTERNAL_SHOW_GAME_MODULE_REQUESTED ) );
		}

	}
}
