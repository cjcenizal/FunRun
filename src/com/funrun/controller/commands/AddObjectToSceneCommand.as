package com.funrun.controller.commands {

	import away3d.containers.ObjectContainer3D;
	
	import com.funrun.model.View3DModel;
	
	import org.robotlegs.mvcs.Command;

	public class AddObjectToSceneCommand extends Command {
		
		[Inject]
		public var object:ObjectContainer3D;
		
		[Inject]
		public var view3DModel:View3DModel;
		
		override public function execute():void {
			view3DModel.addToScene( object );
		}
	}
}
