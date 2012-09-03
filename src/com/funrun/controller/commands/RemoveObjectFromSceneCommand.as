package com.funrun.controller.commands {
	
	import away3d.containers.ObjectContainer3D;
	
	import com.funrun.model.View3dModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class RemoveObjectFromSceneCommand extends Command {
		
		[Inject]
		public var object:ObjectContainer3D;
		
		[Inject]
		public var view3DModel:View3dModel;
		
		override public function execute():void {
			view3DModel.removeFromScene( object );
		}
	}
}
