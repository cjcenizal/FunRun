package com.funrun.view.mediators {

	import com.funrun.controller.signals.EnterLobbyRequest;
	import com.funrun.controller.signals.JoinSinglePlayerGameRequest;
	import com.funrun.view.components.MainMenuView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class MainMenuMediator extends Mediator implements IMediator {

		// Views.
		
		[Inject]
		public var view:MainMenuView;

		// Commands.
		
		[Inject]
		public var enterLobbyRequest:EnterLobbyRequest;
		
		[Inject]
		public var joinSinglePlayerGameRequest:JoinSinglePlayerGameRequest;
		
		override public function onRegister():void {
			// Build our view.
			view.init();
			
			// Listen for view events.
			view.onMultiplayerClickSignal.add( onMultiplayerClicked );
			view.onSinglePlayerClickSignal.add( onSinglePlayerClicked );
		}
		
		private function onMultiplayerClicked():void {
			enterLobbyRequest.dispatch();
		}
		
		private function onSinglePlayerClicked():void {
			joinSinglePlayerGameRequest.dispatch();
		}

	}
}
