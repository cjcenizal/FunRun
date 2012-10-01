package com.funrun.view.mediators {

	import com.funrun.controller.signals.JoinLobbyRequest;
	import com.funrun.controller.signals.ClickStartGameRequest;
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.view.components.MainMenuView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class MainMenuMediator extends Mediator implements IMediator {

		[Inject]
		public var view:MainMenuView;

		[Inject]
		public var enableMainMenuRequest:EnableMainMenuRequest;
		
		[Inject]
		public var clickJoinLobbyRequest:JoinLobbyRequest;
		
		override public function onRegister():void {
			// Build our view.
			view.init();

			// Listen for signals.
			enableMainMenuRequest.add( onEnableMainMenuRequested );
			
			// Listen for view events.
			view.onJoinLobbyClick.add( onJoinLobbyClick );
		}
		
		private function onEnableMainMenuRequested( enabled:Boolean ):void {
			view.optionsEnabled = enabled;
		}

		private function onJoinLobbyClick():void {
			clickJoinLobbyRequest.dispatch();
		}

	}
}
