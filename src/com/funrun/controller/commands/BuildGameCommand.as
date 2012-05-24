package com.funrun.controller.commands
{
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FilteredShadowMapMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	
	import com.funrun.controller.signals.AddLightRequest;
	import com.funrun.controller.signals.AddMaterialRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddPlayerRequest;
	import com.funrun.controller.signals.LoadBlocksRequest;
	import com.funrun.controller.signals.LoadFloorsRequest;
	import com.funrun.controller.signals.LoadObstaclesRequest;
	import com.funrun.model.LightsModel;
	import com.funrun.model.MaterialsModel;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * BuildGameCommand assigns materials and lights to the track.
	 */
	public class BuildGameCommand extends Command {
		
		[Inject]
		public var lightsModel:LightsModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		[Inject]
		public var addMaterialRequest:AddMaterialRequest;
		
		[Inject]
		public var loadBlocksRequest:LoadBlocksRequest;
		
		[Inject]
		public var loadObstaclesRequest:LoadObstaclesRequest;
		
		[Inject]
		public var loadFloorsRequest:LoadFloorsRequest;
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var addLightRequest:AddLightRequest;
		
		[Inject]
		public var addPlayerRequest:AddPlayerRequest;
		
		override public function execute():void {
			// Add materials.
			addMaterialRequest.dispatch( MaterialsModel.PLAYER_MATERIAL, new ColorMaterial( 0x00FF00 ) );
			addMaterialRequest.dispatch( MaterialsModel.GROUND_MATERIAL, new ColorMaterial( 0xFF0000 ) );
			addMaterialRequest.dispatch( MaterialsModel.OBSTACLE_MATERIAL, new ColorMaterial( 0x0000FF ) );
			
			// Load stuff.
			loadBlocksRequest.dispatch();
			loadObstaclesRequest.dispatch();
			loadFloorsRequest.dispatch();
			
			// Add lights.
			var sun:DirectionalLight = new DirectionalLight( .25, -1, -1 );
			sun.castsShadows = true;
			sun.ambient = .05; // Higher = "brighter"
			sun.diffuse = .1; // Higher = "brighter"
			sun.z = 2000;
			var spotlight:PointLight = new PointLight();
			spotlight.castsShadows = true;
			spotlight.shadowMapper.depthMapSize = 1024;
			spotlight.y = 700;
			spotlight.color = 0xffffff;
			spotlight.diffuse = 1;
			spotlight.specular = 1;
			spotlight.radius = 800;
			spotlight.fallOff = 2000;
			spotlight.ambientColor = 0xa0a0c0;
			spotlight.ambient = .5;
			addLightRequest.dispatch( LightsModel.SUN, sun );
			addLightRequest.dispatch( LightsModel.SPOTLIGHT, spotlight );
			
			// Assign properties to materials.
			var sunlight:DirectionalLight = lightsModel.getLight( LightsModel.SUN ) as DirectionalLight; // Casting doesn't feel too clean here
			var spotlight:PointLight = lightsModel.getLight( LightsModel.SPOTLIGHT ) as PointLight; // Casting doesn't feel too clean here
			var shadowMethod:FilteredShadowMapMethod = new FilteredShadowMapMethod( sunlight );
			var specularMethod:FresnelSpecularMethod = new FresnelSpecularMethod();
			var lightPicker:StaticLightPicker = new StaticLightPicker( [ sunlight, spotlight ] );
			var playerMaterial:ColorMaterial = materialsModel.getMaterial( MaterialsModel.PLAYER_MATERIAL );
			var groundMaterial:ColorMaterial = materialsModel.getMaterial( MaterialsModel.GROUND_MATERIAL );
			var obstacleMaterial:ColorMaterial = materialsModel.getMaterial( MaterialsModel.OBSTACLE_MATERIAL );
			
			playerMaterial.lightPicker = lightPicker;
			playerMaterial.shadowMethod = shadowMethod;
			playerMaterial.specular = .25;
			playerMaterial.gloss = 20;
			playerMaterial.specularMethod = specularMethod;
			
			groundMaterial.lightPicker = lightPicker;
			groundMaterial.shadowMethod = shadowMethod;
			groundMaterial.specular = .25;
			groundMaterial.gloss = 20;
			groundMaterial.specularMethod = specularMethod;
			
			obstacleMaterial.lightPicker = lightPicker;
			obstacleMaterial.shadowMethod = shadowMethod;
			obstacleMaterial.specular = .25;
			obstacleMaterial.gloss = 20;
			obstacleMaterial.specularMethod = specularMethod;
			
			// TO-DO:
			// Add a camera here, and replace the one that comes with View3D.
			
			// Add lights to track.
			addObjectToSceneRequest.dispatch( sunlight );
			addObjectToSceneRequest.dispatch( spotlight );
			
			// Add player to track.
			addPlayerRequest.dispatch();
		}
	}
}