package com.funrun.controller.commands {

	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.model.View3DModel;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateObserverLoopCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3DModel:View3DModel;
		
		// Commands.
		
		[Inject]
		public var renderSceneRequest:RenderSceneRequest;
		
		override public function execute():void {
			// Position camera.
			view3DModel.lookAt( new Vector3D() );
			
			// Update track.
			
			
			// Update camera.
			view3DModel.update();
			
			// Render.
			renderSceneRequest.dispatch();
		}
	}
}
