package com.funrun.controller.commands
{
	
	import away3d.lights.LightBase;
	
	import com.funrun.model.LightsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.View3DModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateViewCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var view3DModel:View3DModel;
		
		[Inject]
		public var lightsModel:LightsModel;
		
		override public function execute():void {
			// Update camera before updating competitors.
			updateCamera();
			
			updateLights();
			
			// Set position to mesh.
			playerModel.updateMeshPosition();
		}
		
		private function updateCamera():void {
			view3DModel.setCameraPosition( playerModel.position.x, playerModel.position.y, playerModel.position.z );
			view3DModel.update();
		}
		
		private function updateLights():void {
			var light:LightBase = lightsModel.getLight( LightsModel.SPOTLIGHT );
			light.z = playerModel.position.z;
		}
	}
}