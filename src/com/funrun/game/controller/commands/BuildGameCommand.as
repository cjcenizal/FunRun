package com.funrun.game.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FilteredShadowMapMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.primitives.CylinderGeometry;
	import away3d.primitives.PlaneGeometry;
	
	import com.funrun.game.controller.events.AddPlayerFulfilled;
	import com.funrun.game.controller.events.AddSceneObjectFulfilled;
	import com.funrun.game.model.Constants;
	import com.funrun.game.model.LightsModel;
	import com.funrun.game.model.MaterialsModel;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * BuildGameCommand assigns materials and lights to the track.
	 */
	public class BuildGameCommand extends Command {
		
		[Inject]
		public var lightsModel:LightsModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		override public function execute():void {
			trace(this, "execute");
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
			
			groundMaterial = new ColorMaterial( 0xFF0000 );
			groundMaterial.lightPicker = lightPicker;
			groundMaterial.shadowMethod = shadowMethod;
			groundMaterial.specular = .25;
			groundMaterial.gloss = 20;
			groundMaterial.specularMethod = specularMethod;
			
			obstacleMaterial = new ColorMaterial( 0x0000FF );
			obstacleMaterial.lightPicker = lightPicker;
			obstacleMaterial.shadowMethod = shadowMethod;
			obstacleMaterial.specular = .25;
			obstacleMaterial.gloss = 20;
			obstacleMaterial.specularMethod = specularMethod;
			
			// Add lights to track.
			eventDispatcher.dispatchEvent( new AddSceneObjectFulfilled( AddSceneObjectFulfilled.ADD_SCENE_OBJECT_FULFILLED, sunlight ) );
			eventDispatcher.dispatchEvent( new AddSceneObjectFulfilled( AddSceneObjectFulfilled.ADD_SCENE_OBJECT_FULFILLED, spotlight ) );
			
			// Add ground to track.
			var ground:Mesh = new Mesh( new PlaneGeometry( Constants.TRACK_WIDTH, Constants.TRACK_LENGTH ), groundMaterial );
			ground.position = new Vector3D( 0, 0, Constants.TRACK_LENGTH * .5 - 300 );
			eventDispatcher.dispatchEvent( new AddSceneObjectFulfilled( AddSceneObjectFulfilled.ADD_SCENE_OBJECT_FULFILLED, ground ) );
			
			// Add player to track.
			var player:Mesh = new Mesh( new CylinderGeometry( 50, 50, 50 ), playerMaterial );
			player.position = new Vector3D( 0, 25, 0 );
			eventDispatcher.dispatchEvent( new AddPlayerFulfilled( AddPlayerFulfilled.ADD_PLAYER_FULFILLED, player ) );
			
		}
	}
}