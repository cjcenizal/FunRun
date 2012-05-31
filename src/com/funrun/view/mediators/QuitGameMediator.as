package com.funrun.view.mediators {

	import com.funrun.controller.signals.LeaveGameRequest;
	import com.funrun.view.components.QuitGameView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class QuitGameMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:QuitGameView;
		
		[Inject]
		public var leaveGameRequest:LeaveGameRequest;
		
		override public function onRegister():void {
			view.init();
			view.onClick.add( onQuitGameClicked );
		}
		
		private function onQuitGameClicked():void {
			leaveGameRequest.dispatch();
		}
		
	}
}
