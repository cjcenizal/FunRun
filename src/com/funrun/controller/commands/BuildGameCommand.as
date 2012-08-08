package com.funrun.controller.commands {
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.View3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FilteredShadowMapMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.materials.methods.HardShadowMapMethod;
	import away3d.materials.methods.SoftShadowMapMethod;
	import away3d.materials.methods.TripleFilteredShadowMapMethod;
	
	import com.funrun.controller.signals.AddLightRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddPlayerRequest;
	import com.funrun.controller.signals.AddView3DRequest;
	import com.funrun.controller.signals.ShowStatsRequest;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.LightsModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.Camera;
	import com.funrun.model.constants.Materials;
	import com.funrun.model.constants.Time;
	import com.funrun.model.state.ProductionState;
	
	import org.robotlegs.mvcs.Command;
	
	public class BuildGameCommand extends Command {
		
		// State.
		
		[Inject]
		public var productionState:ProductionState;
		
		// Models.
		
		[Inject]
		public var lightsModel:LightsModel;
		
		[Inject]
		public var cameraModel:View3DModel;
		
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
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var addLightRequest:AddLightRequest;
		
		[Inject]
		public var addPlayerRequest:AddPlayerRequest;
		
		[Inject]
		public var addView3DRequest:AddView3DRequest;
		
		[Inject]
		public var showStatsRequest:ShowStatsRequest;
		
		override public function execute():void {
			// Show stats if we're in development.
			showStatsRequest.dispatch( !productionState.isProduction );
			
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
			interpolationModel.setIncrement( Time.INTERPOLATION_INCREMENT );
			
			// Time.
			timeModel.stage = contextView.stage;
			timeModel.init();
			
			// Add view.
			var camera:Camera3D = new Camera3D( new PerspectiveLens( Camera.FOV ) );
			camera.lens.far = Camera.FRUSTUM_DISTANCE;
			var view:View3D = new View3D( null, camera );
			view.antiAlias = 2; // 2, 4, or 16
			view.width = contextView.stage.stageWidth;
			view.height = contextView.stage.stageHeight;
			view.backgroundColor = 0xffffff;
			cameraModel.setView( view );
			addView3DRequest.dispatch( view );
			
			// Add materials.
			/*
			TO-DO: Add fog and light picker to all materials.
			var playerFog:FogMethod = new FogMethod( TrackConstants.FOG_NEAR, TrackConstants.FOG_FAR, 0xffffff );
			var playerMaterial:ColorMaterial = new ColorMaterial( 0x00FF00 );
			playerMaterial.addMethod( playerFog );
			var textureFog:FogMethod = new FogMethod( TrackConstants.FOG_NEAR, TrackConstants.FOG_FAR, 0xffffff );
			*/
			
			//loadSegmentsRequest.dispatch();
			
			
			// Add lights.
			var sunlight:DirectionalLight = new DirectionalLight( .25, -1, -1 );
			sunlight.ambient = .05; // Higher = "brighter"
			sunlight.diffuse = .1; // Higher = "brighter"
			sunlight.z = 2000;
			var spotlight:PointLight = new PointLight();
			spotlight.y = 700;
			spotlight.color = 0xffffff;
			spotlight.diffuse = 1;
			spotlight.specular = 1;
			spotlight.radius = 800;
			spotlight.fallOff = 2000;
			spotlight.ambientColor = 0xa0a0c0;
			spotlight.ambient = .5;
			addLightRequest.dispatch( LightsModel.SUN, sunlight );
			addLightRequest.dispatch( LightsModel.SPOTLIGHT, spotlight );
			
			
			//var shadowMethod:HardShadowMapMethod = new HardShadowMapMethod( sunlight );
			var shadowMethod:SoftShadowMapMethod = new SoftShadowMapMethod( sunlight );
			//var shadowMethod:FilteredShadowMapMethod = new FilteredShadowMapMethod( sunlight );
			var specularMethod:FresnelSpecularMethod = new FresnelSpecularMethod();
			var lightPicker:StaticLightPicker = new StaticLightPicker( [ sunlight, spotlight ] );
			
			Materials.DEBUG_PLAYER.lightPicker = lightPicker;
			Materials.DEBUG_PLAYER.shadowMethod = shadowMethod;
			Materials.DEBUG_PLAYER.specular = .25;
			Materials.DEBUG_PLAYER.gloss = 20;
			Materials.DEBUG_PLAYER.specularMethod = specularMethod;
			
		/*	floorMaterial.lightPicker = lightPicker;
			floorMaterial.shadowMethod = shadowMethod;
			floorMaterial.specular = .25;
			floorMaterial.gloss = 20;
			floorMaterial.specularMethod = specularMethod;*/
			
			Materials.DEBUG_BLOCK.lightPicker = lightPicker;
			Materials.DEBUG_BLOCK.shadowMethod = shadowMethod;
			Materials.DEBUG_BLOCK.specular = .25;
			Materials.DEBUG_BLOCK.gloss = 20;
			Materials.DEBUG_BLOCK.specularMethod = specularMethod;
			
			// Add lights to track.
			addObjectToSceneRequest.dispatch( sunlight );
			addObjectToSceneRequest.dispatch( spotlight );
			
			// Add player to track.
			addPlayerRequest.dispatch();
		
		}
	}
}
