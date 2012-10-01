package com.funrun.view.mediators {
	
	import com.funrun.controller.signals.RemoveJoiningLobbyPopupRequest;
	import com.funrun.controller.signals.RemovePopupRequest;
	import com.funrun.view.components.FindingGamePopup;
	import com.funrun.view.components.JoiningLobbyPopup;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class JoiningLobbyPopupMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:JoiningLobbyPopup;
		
		[Inject]
		public var removeJoiningLobbyPopupRequest:RemoveJoiningLobbyPopupRequest;
		
		[Inject]
		public var removePopupRequest:RemovePopupRequest;
		
		override public function onRegister():void {
			view.init();
			removeJoiningLobbyPopupRequest.add( onRemoveJoiningLobbyPopupRequest );
		}
		
		override public function onRemove():void {
			view.destroy();
			view = null;
		}
		
		private function onRemoveJoiningLobbyPopupRequest():void {
			removePopupRequest.dispatch( view );
		}
	}
}
