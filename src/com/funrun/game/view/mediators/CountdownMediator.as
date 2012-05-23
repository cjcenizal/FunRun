package com.funrun.game.view.mediators {
	
	import com.funrun.game.view.components.CountdownView;
	
	import flash.display.Stage;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class CountdownMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:CountdownView;
		
		private var stage:Stage;
		
		override public function onRegister():void {
			stage = view.stage;
			view.init();
		}
	}
}
