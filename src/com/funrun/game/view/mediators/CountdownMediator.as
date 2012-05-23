package com.funrun.game.view.mediators {
	
	import com.funrun.game.controller.signals.UpdateCountdownRequest;
	import com.funrun.game.view.components.CountdownView;
	
	import flash.display.Stage;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class CountdownMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:CountdownView;
		
		[Inject]
		public var updateCountdownRequest:UpdateCountdownRequest;
		
		private var stage:Stage;
		
		override public function onRegister():void {
			stage = view.stage;
			view.init();
			
			updateCountdownRequest.add( onUpdateCountdown );
		}
		
		private function onUpdateCountdown( message:String ):void {
			view.countdown = message;
		}
	}
}
