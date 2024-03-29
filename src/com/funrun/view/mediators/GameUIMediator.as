package com.funrun.view.mediators {
	
	import com.funrun.controller.signals.AddToReadyListRequest;
	import com.funrun.controller.signals.ClearReadyListRequest;
	import com.funrun.controller.signals.DrawCountdownRequest;
	import com.funrun.controller.signals.DrawGameMessageRequest;
	import com.funrun.controller.signals.DrawPointsRequest;
	import com.funrun.controller.signals.DrawSpeedRequest;
	import com.funrun.controller.signals.LeaveGameAndEnterLobbyRequest;
	import com.funrun.controller.signals.SendMatchmakingReadyRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.ToggleReadyButtonRequest;
	import com.funrun.controller.signals.ToggleReadyListRequest;
	import com.funrun.controller.signals.vo.AddToReadyListVo;
	import com.funrun.model.GameModel;
	import com.funrun.view.components.GameUIView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class GameUIMediator extends Mediator implements IMediator {
		
		// View.
		
		[Inject]
		public var view:GameUIView;
		
		// Models.
		
		[Inject]
		public var gameModel:GameModel;
		
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
		public var leaveGameRequest:LeaveGameAndEnterLobbyRequest;
		
		[Inject]
		public var sendMatchmakingReadyRequest:SendMatchmakingReadyRequest;
		
		[Inject]
		public var addToReadyListRequest:AddToReadyListRequest;
		
		[Inject]
		public var clearReadyListRequest:ClearReadyListRequest;
		
		[Inject]
		public var toggleReadyListRequest:ToggleReadyListRequest;
		
		[Inject]
		public var toggleReadyButtonRequest:ToggleReadyButtonRequest;
		
		override public function onRegister():void {
			view.init();
			view.onClickQuitSignal.add( onClickQuit );
			view.onClickReadySignal.add( onClickReady );
			drawPointsRequest.add( onDrawPointsRequested );
			drawSpeedRequest.add( onDrawSpeedRequested );
			drawMessageRequest.add( onDrawMessageRequested );
			drawCountdownRequest.add( onUpdateCountdown );
			addToReadyListRequest.add( onAddToReadyListRequested );
			toggleCountdownRequest.add( onToggleCountdownRequested );
			toggleReadyListRequest.add( onToggleReadyListRequested );
			toggleReadyButtonRequest.add( onToggleReadyButtonRequested );
			clearReadyListRequest.add( onClearReadyListRequested );
			view.togglePoints( gameModel.usePoints );
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
		
		private function onToggleCountdownRequested( visible:Boolean ):void {
			if ( visible ) {
				view.showCountdown();
			} else {
				view.hideCountdown();
			}
		}
		
		private function onClearReadyListRequested():void {
			view.clearReadyList();
		}
		
		private function onToggleReadyListRequested( visible:Boolean ):void {
			if ( visible ) {
				view.showReadyList();
			} else {
				view.hideReadyList();
			}
		}
		
		private function onToggleReadyButtonRequested( visible:Boolean ):void {
			if ( visible ) {
				view.showReadyButton();
			} else {
				view.hideReadyButton();
			}
		}
		
		private function onAddToReadyListRequested( vo:AddToReadyListVo ):void {
			view.addToReadyList( vo.id, vo.name, vo.isReady );
		}
		
		private function onClickQuit():void {
			leaveGameRequest.dispatch();
		}
		
		private function onClickReady():void {
			sendMatchmakingReadyRequest.dispatch();
		}
	}
}
