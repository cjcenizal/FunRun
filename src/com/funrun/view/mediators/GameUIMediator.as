package com.funrun.view.mediators {
	
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.LeaveGameRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.UpdateCountdownRequest;
	import com.funrun.view.components.GameUIView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class GameUIMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:GameUIView;
		
		[Inject]
		public var displayDistanceRequest:DisplayDistanceRequest;
		
		[Inject]
		public var updateCountdownRequest:UpdateCountdownRequest;
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var leaveGameRequest:LeaveGameRequest;
		
		override public function onRegister():void {
			view.init();
			view.onClickQuitGameButtonSignal.add( onQuitGameClicked );
			displayDistanceRequest.add( onDisplayDistanceRequested );
			updateCountdownRequest.add( onUpdateCountdown );
			toggleCountdownRequest.add( onToggleCountdown );
		}
		
		private function onDisplayDistanceRequested( message:String ):void {
			view.showDistance( message );
		}
		
		private function onUpdateCountdown( message:String ):void {
			view.countdown = message;
		}
		
		private function onToggleCountdown( visible:Boolean ):void {
			if ( visible ) {
				view.enableCountdown();
			} else {
				view.disableCountdown();
			}
		}
		
		private function onQuitGameClicked():void {
			leaveGameRequest.dispatch();
		}
	}
}
