package com.funrun.view.mediators {

	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.StartGameRequest;
	import com.funrun.view.components.MainMenuView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class MainMenuMediator extends Mediator implements IMediator {

		[Inject]
		public var view:MainMenuView;

		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		[Inject]
		public var startGameRequest:StartGameRequest;
		
		override public function onRegister():void {
			// Build our view.
			view.build();

			// Listen for signals.
			enableMainMenuRequest.add( onEnableMainMenuRequested );
			
			// Listen for view events.
			view.onStartGameButtonClick.add( onStartGameButtonClick );
		}
		
		private function onEnableMainMenuRequested( enabled:Boolean ):void {
			view.optionsEnabled = enabled;
		}

		private function onStartGameButtonClick():void {
			startGameRequest.dispatch();
		}

	}
}
