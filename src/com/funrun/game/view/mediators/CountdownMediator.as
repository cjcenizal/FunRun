package com.funrun.game.view.mediators {
	
	import com.funrun.game.controller.signals.ToggleCountdownRequest;
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
		
		[Inject]
		public var toggleCountdownRequest:ToggleCountdownRequest;
		
		private var stage:Stage;
		
		override public function onRegister():void {
			stage = view.stage;
			view.init();
			
			updateCountdownRequest.add( onUpdateCountdown );
			toggleCountdownRequest.add( onToggleCountdown );
		}
		
		private function onUpdateCountdown( message:String ):void {
			view.countdown = message;
		}
		
		private function onToggleCountdown( visible:Boolean ):void {
			if ( visible ) {
				view.enableCountdown();
			} else {
				view.disableCountdown();
			}
		}
	}
}
