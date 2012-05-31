package com.funrun.view.mediators {
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.AddNametagRequest;
	import com.funrun.controller.signals.RemoveNametagRequest;
	import com.funrun.view.components.NametagsView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class NametagsMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:NametagsView;
		
		[Inject]
		public var addNametagRequest:AddNametagRequest;
		
		[Inject]
		public var removeNametagRequest:RemoveNametagRequest;
		
		override public function onRegister():void {
			view.init();
			addNametagRequest.add( onAddNametagRequested );
			removeNametagRequest.add( onRemoveNametagRequested );
		}
		
		private function onAddNametagRequested( nametag:AbstractLabel ):void {
			view.addChild( nametag );
		}
		
		private function onRemoveNametagRequested( nametag:AbstractLabel ):void {
			view.removeChild( nametag );
		}
	}
}
