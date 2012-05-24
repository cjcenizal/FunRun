package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.primitives.CylinderGeometry;
	
	import com.funrun.controller.events.AddCameraFulfilled;
	import com.funrun.controller.events.AddObjectToSceneRequest;
	import com.funrun.model.CameraModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.PlayerModel;
	
	import flash.geom.Vector3D;
	
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
