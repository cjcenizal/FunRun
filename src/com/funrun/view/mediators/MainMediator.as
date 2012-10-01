package com.funrun.view.mediators {
	
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.state.ScreenState;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	import com.funrun.view.components.MainView;
	
	public class MainMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:MainView;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function onRegister():void {
			view.init();
			view.hideAll();
			showScreenRequest.add( onShowScreenRequested );
		}
		
		private function onShowScreenRequested( screen:String ):void {
			switch ( screen ) {
				case ScreenState.MAIN_MENU:
					view.showMainMenu();
					break;
				case ScreenState.LOBBY:
					view.showLobby();
					break;
				case ScreenState.MULTIPLAYER_GAME:
					view.showGame();
					break;
			}
		}
	}
}
