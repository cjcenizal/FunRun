package com.funrun.view.mediators {
	
	import com.funrun.controller.signals.DrawDistanceRequest;
	import com.funrun.controller.signals.DrawMessageRequest;
	import com.funrun.controller.signals.DrawPlaceRequest;
	import com.funrun.controller.signals.LeaveGameRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.DrawCountdownRequest;
	import com.funrun.view.components.GameUIView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class GameUIMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:GameUIView;
		
		[Inject]
		public var drawPlaceRequest:DrawPlaceRequest;
		
		[Inject]
		public var drawDistanceRequest:DrawDistanceRequest;
		
		[Inject]
		public var drawMessageRequest:DrawMessageRequest;
		
		[Inject]
		public var drawCountdownRequest:DrawCountdownRequest;
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var leaveGameRequest:LeaveGameRequest;
		
		override public function onRegister():void {
			view.init();
			view.onClickQuitGameButtonSignal.add( onQuitGameClicked );
			drawDistanceRequest.add( onDrawDistanceRequested );
			drawPlaceRequest.add( onDrawPlaceRequested );
			drawMessageRequest.add( onDrawMessageRequested );
			drawCountdownRequest.add( onUpdateCountdown );
			toggleCountdownRequest.add( onToggleCountdown );
		}
		
		private function onDrawDistanceRequested( distance:String ):void {
			view.showDistance( distance );
		}
		
		private function onDrawPlaceRequested( place:String ):void {
			view.showPlace( place );
		}
		
		private function onDrawMessageRequested( message:String ):void {
			view.showMessage( message );
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
