package com.funrun.view.mediators {
	
	import com.funrun.view.components.LoginStatusView;
	import com.funrun.controller.signals.UpdateLoginStatusRequest;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class LoginStatusMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:LoginStatusView;
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		override public function onRegister():void {
			view.init();
			updateLoginStatus.add( onUpdateLoginStatusRequested );
		}
		
		private function onUpdateLoginStatusRequested( status:String ):void {
			view.status = status;
		}
	}
}
