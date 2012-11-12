package com.funrun.controller.commands
{
	
	import away3d.lights.LightBase;
	
	import com.funrun.model.LightsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.View3dModel;
	import com.funrun.model.constants.Camera;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateViewCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var lightsModel:LightsModel;
		
		override public function execute():void {
			// Update camera before updating competitors.
			updateCamera();
			
			updateLights();
			
			// Set position to mesh.
			playerModel.updatePosition();
		}
		
		private function updateCamera():void {
			if ( playerModel.isDucking ) {
				view3dModel.setTargetPerspective( 180, Camera.DUCKING_TILT, Camera.DUCKING_DISTANCE );
			} else {
				view3dModel.setTargetPerspective( 180, Camera.RUNNING_TILT, Camera.RUNNING_DISTANCE );
			}
			view3dModel.setTargetPosition( playerModel.position.x, playerModel.position.y, playerModel.position.z );
			view3dModel.update();
		}
		
		private function updateLights():void {
			var light:LightBase = lightsModel.getLight( LightsModel.SPOTLIGHT );
			light.z = playerModel.position.z - 100;
			lightsModel.getLight( LightsModel.SUN ).z = playerModel.position.z;
		}
	}
}