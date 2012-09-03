package com.funrun.controller.commands {

	import com.funrun.model.View3dModel;
	
	import org.robotlegs.mvcs.Command;

	public class RenderSceneCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3DModel:View3dModel;
		
		override public function execute():void {
			view3DModel.render();
		}
	}
}
