package com.funrun.view.mediators {
	
	import com.funrun.controller.signals.DrawCountdownRequest;
	import com.funrun.controller.signals.DrawMessageRequest;
	import com.funrun.controller.signals.DrawPointsRequest;
	import com.funrun.controller.signals.DrawSpeedRequest;
	import com.funrun.controller.signals.LeaveGameRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.view.components.GameUIView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class GameUIMediator extends Mediator implements IMediator {
		
		// View.
		
		[Inject]
		public var view:GameUIView;
		
		// Commands.
		
		[Inject]
		public var drawPointsRequest:DrawPointsRequest;
		
		[Inject]
		public var drawMessageRequest:DrawMessageRequest;
		
		[Inject]
		public var drawCountdownRequest:DrawCountdownRequest;
		
		[Inject]
		public var drawSpeedRequest:DrawSpeedRequest;
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var leaveGameRequest:LeaveGameRequest;
		
		override public function onRegister():void {
			view.init();
			view.onClickQuitGameButtonSignal.add( onQuitGameClicked );
			drawPointsRequest.add( onDrawPointsRequested );
			drawSpeedRequest.add( onDrawSpeedRequested );
			drawMessageRequest.add( onDrawMessageRequested );
			drawCountdownRequest.add( onUpdateCountdown );
			toggleCountdownRequest.add( onToggleCountdown );
		}
		
		private function onDrawPointsRequested( val:Number ):void {
			view.drawPoints( val );
		}
		
		private function onDrawSpeedRequested( val:Number ):void {
			view.drawSpeed( val );
		}
		
		private function onDrawMessageRequested( message:String ):void {
			view.drawMessage( message );
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
