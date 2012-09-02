package com.funrun.controller.commands {
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FogMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.materials.methods.SoftShadowMapMethod;
	import away3d.primitives.CubeGeometry;
	
	import com.funrun.controller.signals.AddLightRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddPlaceableRequest;
	import com.funrun.controller.signals.AddView3DRequest;
	import com.funrun.controller.signals.ShowStatsRequest;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.LightsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.Camera;
	import com.funrun.model.constants.Materials;
	import com.funrun.model.constants.Player;
	import com.funrun.model.constants.Time;
	import com.funrun.model.constants.Track;
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
		public var view3dModel:View3DModel;
		
		[Inject]
		public var interpolationModel:InterpolationModel;
		
		[Inject]
		public var timeModel:TimeModel;
		
		[Inject]
		public var pointsModel:PointsModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var addLightRequest:AddLightRequest;
		
		[Inject]
		public var addView3DRequest:AddView3DRequest;
		
		[Inject]
		public var showStatsRequest:ShowStatsRequest;
		
		[Inject]
		public var addPlaceableRequest:AddPlaceableRequest;
		
		
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
			view3dModel.setView( view );
			addView3DRequest.dispatch( view );
			
			// Add camera target.
			view3dModel.target = new Mesh( new CubeGeometry( 1, 1, 1 ), null );
			addObjectToSceneRequest.dispatch( view3dModel.target );
			
			// Add camera controller.
			var cameraController:HoverController = new HoverController( camera, view3dModel.target );
			cameraController.steps = 1;
			view3dModel.cameraController = cameraController;
			
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
			var sunlight:DirectionalLight = new DirectionalLight( .25, -1, -.5 );
			sunlight.ambient = .05; // Higher = "brighter"
			sunlight.diffuse = .1; // Higher = "brighter"
			sunlight.z = 2000;
			var spotlight:PointLight = new PointLight();
			spotlight.x = Track.WIDTH * .5;
			spotlight.y = 700;
			spotlight.color = 0xffffff;
			spotlight.diffuse = 1;
			spotlight.specular = 1;
			spotlight.radius = 1200;
			spotlight.fallOff = 8000;
			spotlight.ambientColor = 0xa0a0c0;
			spotlight.ambient = .5;
			addLightRequest.dispatch( LightsModel.SUN, sunlight );
			addLightRequest.dispatch( LightsModel.SPOTLIGHT, spotlight );
			
			var shadowMethod:SoftShadowMapMethod = new SoftShadowMapMethod( sunlight );
			var specularMethod:FresnelSpecularMethod = new FresnelSpecularMethod();
			var lightPicker:StaticLightPicker = new StaticLightPicker( [ sunlight, spotlight ] );
			
			Materials.DEBUG_PLAYER.lightPicker = lightPicker;
			Materials.DEBUG_PLAYER.shadowMethod = shadowMethod;
			Materials.DEBUG_PLAYER.specular = .25;
			Materials.DEBUG_PLAYER.gloss = 20;
			Materials.DEBUG_PLAYER.specularMethod = specularMethod;
			
			Materials.DEBUG_BLOCK.lightPicker = lightPicker;
			Materials.DEBUG_BLOCK.shadowMethod = shadowMethod;
			Materials.DEBUG_BLOCK.specular = .25;
			Materials.DEBUG_BLOCK.gloss = 20;
			Materials.DEBUG_BLOCK.specularMethod = specularMethod;
		//	Materials.DEBUG_BLOCK.addMethod( new FogMethod( 1000, 0xffffff ) );
			
			Materials.DEBUG_TEST.lightPicker = lightPicker;
			Materials.DEBUG_TEST.shadowMethod = shadowMethod;
			Materials.DEBUG_TEST.specular = .25;
			Materials.DEBUG_TEST.gloss = 20;
			Materials.DEBUG_TEST.specularMethod = specularMethod;
			
			// Add lights to track.
			addObjectToSceneRequest.dispatch( sunlight );
			addObjectToSceneRequest.dispatch( spotlight );
			
			// Add player to track.
			addPlaceableRequest.dispatch( playerModel );
			playerModel.normalBounds.minX = Player.NORMAL_BOUNDS.x * -.5;
			playerModel.normalBounds.minY = Player.NORMAL_BOUNDS.y * -.5;
			playerModel.normalBounds.minZ = Player.NORMAL_BOUNDS.z * -.5;
			playerModel.normalBounds.maxX = Player.NORMAL_BOUNDS.x * .5;
			playerModel.normalBounds.maxY = Player.NORMAL_BOUNDS.y * .5;
			playerModel.normalBounds.maxZ = Player.NORMAL_BOUNDS.z * .5;
			playerModel.duckingBounds.minX = Player.DUCKING_BOUNDS.x * -.5;
			playerModel.duckingBounds.minY = Player.DUCKING_BOUNDS.y * -.5;
			playerModel.duckingBounds.minZ = Player.DUCKING_BOUNDS.z * -.5;
			playerModel.duckingBounds.maxX = Player.DUCKING_BOUNDS.x * .5;
			playerModel.duckingBounds.maxY = Player.DUCKING_BOUNDS.y * .5;
			playerModel.duckingBounds.maxZ = Player.DUCKING_BOUNDS.z * .5;
			var geometry:CubeGeometry = new CubeGeometry( Player.NORMAL_BOUNDS.x, Player.NORMAL_BOUNDS.y, Player.NORMAL_BOUNDS.z );
			var player:Mesh = new Mesh( geometry, Materials.DEBUG_PLAYER );
			playerModel.mesh = player;
			addObjectToSceneRequest.dispatch( player );
			
		}
	}
}
