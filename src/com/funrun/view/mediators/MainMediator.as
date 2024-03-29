package com.funrun.view.mediators {
	
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.constants.Screen;
	
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
				case Screen.MAIN_MENU:
					view.showMainMenu();
					break;
				case Screen.LOBBY:
					view.showLobby();
					break;
				case Screen.MULTIPLAYER_GAME:
					view.showGame();
					break;
			}
		}
	}
}
