package com.funrun.controller.commands
{
	
	import com.funrun.model.MouseModel;
	import com.funrun.model.View3dModel;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class MouseDownCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var event:MouseEvent;
		
		// Models.
		
		[Inject]
		public var mouseModel:MouseModel;
		
		[Inject]
		public var view3dModel:View3dModel;
		
		override public function execute():void {
			trace("mouse down");
			mouseModel.setMouseDown( contextView.stage.mouseX, contextView.stage.mouseY );
			view3dModel.lastPanAngle = view3dModel.panAngle;
			view3dModel.lastTiltAngle = view3dModel.tiltAngle;
			view3dModel.lastMouseX = contextView.stage.mouseX;
			view3dModel.lastMouseY = contextView.stage.mouseY;
		}
	}
}