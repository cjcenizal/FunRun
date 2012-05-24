package com.funrun.view.mediators {
	
	import com.funrun.view.components.PopupsView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class PopupsMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:PopupsView;
		
		override public function onRegister():void {
			view.init();
		}
	}
}
