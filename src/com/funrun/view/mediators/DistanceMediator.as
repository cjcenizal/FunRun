package com.funrun.view.mediators {
	
	import com.cenizal.utils.Numbers;
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.view.components.DistanceView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class DistanceMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:DistanceView;
		
		[Inject]
		public var displayDistanceRequest:DisplayDistanceRequest;
		
		override public function onRegister():void {
			view.init();
			displayDistanceRequest.add( onDisplayDistanceRequested );
		}
		
		private function onDisplayDistanceRequested( message:String ):void {
			view.showDistance( message );
		}
	
	}
}
