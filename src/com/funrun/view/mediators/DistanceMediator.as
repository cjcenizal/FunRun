package com.funrun.view.mediators {
	
	import com.cenizal.util.Numbers;
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.view.components.DistanceView;
	
	import flash.display.Stage;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class DistanceMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:DistanceView;
		
		[Inject]
		public var displayDistanceRequest:DisplayDistanceRequest;
		
		private var stage:Stage;
		
		override public function onRegister():void {
			stage = view.stage;
			displayDistanceRequest.add( onDisplayDistanceRequested );
		}
		
		private function onDisplayDistanceRequested( distance:Number ):void {
			view.showDistance( Numbers.addCommas( ( Math.round( distance * .05 ) ).toString() ) );
		}
	
	}
}
