package com.funrun.controller.commands {
	
	import com.funrun.controller.events.AddCameraFulfilled;
	import com.funrun.model.CameraModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddCameraCommand extends Command {
		
		[Inject]
		public var event:AddCameraFulfilled;
		
		[Inject]
		public var cameraModel:CameraModel;
		
		override public function execute():void {
			cameraModel.setCamera( event.camera );
		}
	}
}
