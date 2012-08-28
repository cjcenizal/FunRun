package com.funrun.controller.commands
{
	
	import away3d.lights.LightBase;
	
	import com.funrun.model.LightsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.Camera;
	
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
			view3DModel.cameraX = playerModel.position.x;
			var followFactor:Number = ( Camera.Y + playerModel.position.y < view3DModel.cameraY ) ? .3 : .1;
			// We'll try easing to follow the player instead of being locked.
			view3DModel.cameraY += ( ( Camera.Y + playerModel.position.y ) - view3DModel.cameraY ) * followFactor;
			view3DModel.cameraZ += ( ( playerModel.position.z + Camera.Z ) - view3DModel.cameraZ ) * .65;
			view3DModel.update();
		}
		
		private function updateLights():void {
			var light:LightBase = lightsModel.getLight( LightsModel.SPOTLIGHT );
			light.z = playerModel.position.z;
		}
	}
}