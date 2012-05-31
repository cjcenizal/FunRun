package com.funrun.view.mediators {

	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.RemovePopupRequest;
	import com.funrun.view.components.FindingGamePopup;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class FindingGamePopupMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:FindingGamePopup;

		[Inject]
		public var removeFindingGamePopupRequest:RemoveFindingGamePopupRequest;

		[Inject]
		public var removePopupRequest:RemovePopupRequest;

		override public function onRegister():void {
			view.init();
			removeFindingGamePopupRequest.add( onRemoveFindingGamePopup );
		}

		override public function onRemove():void {
			view.destroy();
			view = null;
		}

		private function onRemoveFindingGamePopup():void {
			removePopupRequest.dispatch( view );
		}
	}
}
