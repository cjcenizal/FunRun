package com.funrun.game.view.mediators {
	
	import com.funrun.game.view.components.DistanceView;
	
	import flash.display.Stage;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class DistanceMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:DistanceView;
		
		private var stage:Stage;
		
		override public function onRegister():void {
			stage = view.stage;
			//view.init();
		}
	
	}
}
