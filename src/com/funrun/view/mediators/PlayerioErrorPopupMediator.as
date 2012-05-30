package com.funrun.view.mediators {
	
	import com.funrun.view.components.PlayerioErrorPopupView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class PlayerioErrorPopupMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:PlayerioErrorPopupView;
		
		override public function onRegister():void {
			view.init();
		}
		
		override public function onRemove():void {
			view.destroy();
			view = null;
		}
	}
}
