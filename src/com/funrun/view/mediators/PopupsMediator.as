package com.funrun.view.mediators {
	
	import com.cenizal.ui.AbstractComponent;
	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.controller.signals.RemovePopupRequest;
	import com.funrun.view.components.Popup;
	import com.cenizal.utils.Center;
	import com.funrun.view.components.PopupsView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class PopupsMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:PopupsView;
		
		[Inject]
		public var addPopupRequest:AddPopupRequest;
		
		[Inject]
		public var removePopupRequest:RemovePopupRequest;
		
		override public function onRegister():void {
			view.init();
			addPopupRequest.add( onAddPopupRequested );
			removePopupRequest.add( onRemovePopupRequested );
		}
		
		private function onAddPopupRequested( popup:Popup ):void {
			view.add( popup );
			Center.bothVals( popup, view.stage.stageWidth, view.stage.stageHeight );
		}
		
		private function onRemovePopupRequested( popup:Popup ):void {
			view.remove( popup );
		}
	}
}
