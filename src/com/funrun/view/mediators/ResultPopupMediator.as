package com.funrun.view.mediators {

	import com.funrun.controller.signals.LeaveGameRequest;
	import com.funrun.controller.signals.RemovePopupRequest;
	import com.funrun.controller.signals.RemoveResultsPopupRequest;
	import com.funrun.view.components.ResultsPopup;

	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class ResultPopupMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:ResultsPopup;

		[Inject]
		public var leaveGameRequest:LeaveGameRequest;

		[Inject]
		public var removeResultsPopupRequest:RemoveResultsPopupRequest;

		[Inject]
		public var removePopupRequest:RemovePopupRequest;

		override public function onRegister():void {
			view.init();
			view.onClickMainMenuSignal.add( onClickMainMenu );
			removeResultsPopupRequest.add( onRemoveResultsPopup );
		}

		override public function onRemove():void {
			view.destroy();
			view = null;
		}

		private function onClickMainMenu():void {
			leaveGameRequest.dispatch();
		}

		private function onRemoveResultsPopup():void {
			removePopupRequest.dispatch( view );
		}

	}
}
