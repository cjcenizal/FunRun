package com.funrun.mainmenu.view.mediators {
	
	import com.funrun.mainmenu.view.components.LoginStatusView;
	import com.funrun.modulemanager.controller.signals.UpdateLoginStatusRequest;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class LoginStatusMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:LoginStatusView;
		
		[Inject]
		public var updateLoginStatus:UpdateLoginStatusRequest;
		
		public function LoginStatusMediator() {
			super();
		}
		
		override public function onRegister():void {
			trace(this, "onRegister");
			updateLoginStatus.add( onUpdateLoginStatusRequested );
		}
		
		private function onUpdateLoginStatusRequested( status:String ):void {
			trace("onUpdateLoginStatusRequested: " + status);
			view.status = status;
		}
	}
}
