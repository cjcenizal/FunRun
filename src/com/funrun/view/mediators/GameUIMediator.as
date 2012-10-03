package com.funrun.view.mediators {
	
	import com.funrun.controller.signals.DrawCountdownRequest;
	import com.funrun.controller.signals.DrawGameMessageRequest;
	import com.funrun.controller.signals.DrawPointsRequest;
	import com.funrun.controller.signals.DrawSpeedRequest;
	import com.funrun.controller.signals.LeaveGameRequest;
	import com.funrun.controller.signals.SendMatchmakingReadyRequest;
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
		public var drawMessageRequest:DrawGameMessageRequest;
		
		[Inject]
		public var drawCountdownRequest:DrawCountdownRequest;
		
		[Inject]
		public var drawSpeedRequest:DrawSpeedRequest;
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		[Inject]
		public var leaveGameRequest:LeaveGameRequest;
		
		[Inject]
		public var sendMatchmakingReadyRequest:SendMatchmakingReadyRequest;
		
		override public function onRegister():void {
			view.init();
			view.onClickQuitSignal.add( onClickQuit );
			view.onClickReadySignal.add( onClickReady );
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
				view.showCountdown();
			} else {
				view.hideCountdown();
			}
		}
		
		private function onClickQuit():void {
			leaveGameRequest.dispatch();
		}
		
		private function onClickReady():void {
			sendMatchmakingReadyRequest.dispatch();
		}
	}
}
