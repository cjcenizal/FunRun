package com.funrun.view.mediators
{
	import com.funrun.controller.signals.RemovePopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.state.ScreenState;
	import com.funrun.view.components.ResultsPopup;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class ResultPopupMediator extends Mediator implements IMediator
	{
		[Inject]
		public var view:ResultsPopup;
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		[Inject]
		public var removePopupRequest:RemovePopupRequest;
		
		override public function onRegister():void {
			view.init();
			view.onClickMainMenuSignal.add( onClickMainMenu );
		}
		
		override public function onRemove():void {
			view.destroy();
			view = null;
		}
		
		private function onClickMainMenu():void {
			showScreenRequest.dispatch( ScreenState.MAIN_MENU );
			removePopupRequest.dispatch( view );
		}
		
	}
}