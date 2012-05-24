package com.funrun.game {
	
	import com.funrun.game.controller.signals.ShowScreenRequest;
	import com.funrun.game.model.state.ScreenState;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:MainView;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function onRegister():void {
			view.build();
			showScreenRequest.add( onShowScreenRequested );
		}
		
		private function onShowScreenRequested( screen:String ):void {
			switch ( screen ) {
				case ScreenState.MAIN_MENU:
					view.showMainMenu();
					break;
				case ScreenState.MULTIPLAYER_GAME:
					view.showGame();
					break;
			}
		}
	}
}
