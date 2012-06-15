package com.funrun.controller.commands {

	import com.funrun.model.View3DModel;
	
	import org.robotlegs.mvcs.Command;

	public class RenderSceneCommand extends Command {
		
		// Models.
		
		[Inject]
		public var view3DModel:View3DModel;
		
		override public function execute():void {
			view3DModel.render();
		}
	}
}
