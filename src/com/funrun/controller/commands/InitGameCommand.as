package com.funrun.controller.commands
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.View3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FilteredShadowMapMethod;
	import away3d.materials.methods.FogMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	
	import com.funrun.controller.signals.AddLightRequest;
	import com.funrun.controller.signals.AddMaterialRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddPlayerRequest;
	import com.funrun.controller.signals.AddView3DRequest;
	import com.funrun.controller.signals.LoadBlocksRequest;
	import com.funrun.controller.signals.LoadSegmentsRequest;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.LightsModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.TimeConstants;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * BuildGameCommand assigns materials and lights to the track.
	 */
	public class InitGameCommand extends Command {
		
		// Models.
		
		[Inject]
		public var lightsModel:LightsModel;
		
		[Inject]
		public var cameraModel:View3DModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		[Inject]
		public var keyboardModel:KeyboardModel;
		
		[Inject]
		public var interpolationModel:InterpolationModel;
		
		[Inject]
		public var timeModel:TimeModel;
		
		[Inject]
		public var pointsModel:PointsModel;
		
		// Commands.
		
		[Inject]
		public var addMaterialRequest:AddMaterialRequest;
		
		[Inject]
		public var loadBlocksRequest:LoadBlocksRequest;
		
		[Inject]
		public var loadSegmentsRequest:LoadSegmentsRequest;
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var addLightRequest:AddLightRequest;
		
		[Inject]
		public var addPlayerRequest:AddPlayerRequest;
		
		[Inject]
		public var addView3DRequest:AddView3DRequest;
		
		override public function execute():void {
			// Assign points to places.
			pointsModel.assign( 0, 10 );
			pointsModel.assign( 1, 9 );
			pointsModel.assign( 2, 8 );
			pointsModel.assign( 3, 6 );
			pointsModel.assign( 4, 4 );
			pointsModel.assign( 5, 2 );
			pointsModel.assign( 6, 1 );
			
			// Keyboard.
			keyboardModel.stage = contextView.stage;
			keyboardModel.init();
			
			// Interpolation.
			interpolationModel.setIncrement( TimeConstants.INTERPOLATION_INCREMENT );
			
			// Time.
			timeModel.stage = contextView.stage;
			timeModel.init();
			
			// Add view.
			var camera:Camera3D = new Camera3D( new PerspectiveLens( TrackConstants.CAM_FOV ) );
			camera.lens.far = TrackConstants.CAM_FRUSTUM_DISTANCE;
			var view:View3D = new View3D( null, camera );
			view.antiAlias = 2; // 2, 4, or 16
			view.width = contextView.stage.stageWidth;
			view.height = contextView.stage.stageHeight;
			view.backgroundColor = 0xffffff;
			cameraModel.setView( view );
			addView3DRequest.dispatch( view );
			
			// Add materials.
			var fog:FogMethod = new FogMethod( TrackConstants.TRACK_DEPTH - 2000, TrackConstants.TRACK_DEPTH, 0xffffff );
			var playerMaterial:ColorMaterial = new ColorMaterial( 0x00FF00 );
			playerMaterial.addMethod( fog );
			var floorMaterial:ColorMaterial = new ColorMaterial( 0xFF0000 );
			floorMaterial.addMethod( fog );
			var obstacleMaterial:ColorMaterial = new ColorMaterial( 0x0000FF );
			obstacleMaterial.addMethod( fog );
			addMaterialRequest.dispatch( MaterialsModel.PLAYER_MATERIAL, playerMaterial );
			addMaterialRequest.dispatch( MaterialsModel.FLOOR_MATERIAL, floorMaterial );
			addMaterialRequest.dispatch( MaterialsModel.OBSTACLE_MATERIAL, obstacleMaterial );
			
			// Load stuff.
			loadBlocksRequest.dispatch();
			loadSegmentsRequest.dispatch();
			
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
			var groundMaterial:ColorMaterial = materialsModel.getMaterial( MaterialsModel.FLOOR_MATERIAL );
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
			
			// Add lights to track.
			addObjectToSceneRequest.dispatch( sunlight );
			addObjectToSceneRequest.dispatch( spotlight );
			
			// Add player to track.
			addPlayerRequest.dispatch();
		}
	}
}