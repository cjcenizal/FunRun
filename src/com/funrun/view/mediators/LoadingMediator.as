package com.funrun.view.mediators {
	
	import com.funrun.controller.signals.HideLoadingRequest;
	import com.funrun.controller.signals.ShowLoadingRequest;
	import com.funrun.controller.signals.UpdateLoadingRequest;
	import com.funrun.view.components.LoadingView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class LoadingMediator extends Mediator implements IMediator {
		
		// View.
		
		[Inject]
		public var view:LoadingView;
		
		// Commands.
		
		[Inject]
		public var showLoadingRequest:ShowLoadingRequest;
		
		[Inject]
		public var updateLoadingRequest:UpdateLoadingRequest;
		
		[Inject]
		public var hideLoadingRequest:HideLoadingRequest;
		
		override public function onRegister():void {
			view.init();
			showLoadingRequest.add( onShowLoadingRequested );
			updateLoadingRequest.add( onUpdateLoadingRequested );
			hideLoadingRequest.add( onHideLoadingRequested );
		}
		
		private function onShowLoadingRequested( message:String ):void {
			view.show();
			view.message = message;
		}
		
		private function onUpdateLoadingRequested( message:String ):void {
			view.message = message;
		}
		
		private function onHideLoadingRequested():void {
			view.hide();
		}
	}
}
