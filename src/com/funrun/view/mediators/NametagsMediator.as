package com.funrun.view.mediators {
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.AddNametagRequest;
	import com.funrun.view.components.NametagsView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class NametagsMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:NametagsView;
		
		[Inject]
		public var addNametagRequest:AddNametagRequest;
		
		override public function onRegister():void {
			view.init();
			addNametagRequest.add( onAddNametagRequested );
		}
		
		private function onAddNametagRequested( nametag:AbstractLabel ):void {
			view.addChild( nametag );
		}
		
	}
}
