package com.funrun.game.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.primitives.CylinderGeometry;
	
	import com.funrun.game.controller.events.AddCameraFulfilled;
	import com.funrun.game.controller.events.AddObjectToSceneRequest;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.PlayerModel;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddCameraCommand extends Command {
		
		[Inject]
		public var event:AddCameraFulfilled;
		
		[Inject]
		public var cameraModel:CameraModel;
		
		override public function execute():void {
			cameraModel.camera = event.camera;
		}
	}
}
