package com.funrun.view.mediators {

	import com.funrun.view.components.GameView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class GameMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:GameView;
		
		override public function onRegister():void {
			view.build();
		}
	}
}
