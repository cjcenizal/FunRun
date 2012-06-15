package com.funrun.view.mediators
{
	import away3d.containers.View3D;
	
	import com.funrun.controller.signals.AddView3DRequest;
	import com.funrun.view.components.TrackView;
	
	import flash.display.Stage;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class TrackMediator extends Mediator implements IMediator
	{
		[Inject]
		public var view:TrackView;
		
		[Inject]
		public var addView3DRequest:AddView3DRequest;
		
		private var stage:Stage;
		
		override public function onRegister():void {
			stage = view.stage;
			view.init();
			view.debug();
			addView3DRequest.add( onAddView3DRequested );
		}
		
		private function onAddView3DRequested( view3D:View3D ):void {
			this.view.view3D = view3D;
		}
	}
}