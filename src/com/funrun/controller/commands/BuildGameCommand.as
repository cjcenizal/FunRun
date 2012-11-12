package com.funrun.controller.commands {
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FogMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.materials.methods.SoftShadowMapMethod;
	import away3d.primitives.CubeGeometry;
	
	import com.funrun.controller.signals.AddLightRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddPlaceableRequest;
	import com.funrun.controller.signals.AddView3DRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.SelectCharacterRequest;
	import com.funrun.controller.signals.ShowStatsRequest;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.ColorsModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.LightsModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.RewardsModel;
	import com.funrun.model.SoundsModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.View3dModel;
	import com.funrun.model.constants.Camera;
	import com.funrun.model.constants.Materials;
	import com.funrun.model.constants.Player;
	import com.funrun.model.constants.Time;
	import com.funrun.model.constants.Track;
	import com.funrun.model.constants.World;
	import com.funrun.model.vo.BlockStyleVo;
	
	import org.robotlegs.mvcs.Command;

	
	public class BuildGameCommand extends Command {
		
		// State.
		
		[Inject]
		public var productionState:GameModel;
		
		// Models.
		
		[Inject]
		public var lightsModel:LightsModel;
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var interpolationModel:InterpolationModel;
		
		[Inject]
		public var timeModel:TimeModel;
		
		[Inject]
		public var rewardsModel:RewardsModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		[Inject]
		public var colorsModel:ColorsModel;
		
		[Inject]
		public var materialsModel:MaterialsModel;
		
		[Inject]
		public var soundsModel:SoundsModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var addLightRequest:AddLightRequest;
		
		[Inject]
		public var addView3DRequest:AddView3DRequest;
		
		[Inject]
		public var showStatsRequest:ShowStatsRequest;
		
		[Inject]
		public var addPlaceableRequest:AddPlaceableRequest;
		
		[Inject]
		public var selectCharacterRequest:SelectCharacterRequest;
		
		override public function execute():void {
			blockStylesModel.currentStyle = blockStylesModel.getStyle( "grass" );
			
			// Show stats if we're in development.
			showStatsRequest.dispatch( productionState.showStats );
			
			// Assign points to places.
			rewardsModel.assignRewardFor( 0, 10 );
			rewardsModel.assignRewardFor( 1, 9 );
			rewardsModel.assignRewardFor( 2, 8 );
			rewardsModel.assignRewardFor( 3, 6 );
			rewardsModel.assignRewardFor( 4, 4 );
			rewardsModel.assignRewardFor( 5, 2 );
			rewardsModel.assignRewardFor( 6, 1 );
			
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
			view.backgroundColor = World.BACKGROUND_COLOR;
			view3dModel.setView( view );
			addView3DRequest.dispatch( view );
			
			// Add camera target.
			view3dModel.target = new Mesh( new CubeGeometry( 1, 1, 1 ), null );
			addObjectToSceneRequest.dispatch( view3dModel.target );
			
			// Add camera controller.
			var cameraController:HoverController = new HoverController( camera, view3dModel.target );
			cameraController.steps = 1;
			view3dModel.setCameraController( cameraController );
			
			// Add lights.
			var sunlight:DirectionalLight = new DirectionalLight( .25, -1, -.5 );
			addLightRequest.dispatch( LightsModel.SUN, sunlight );
			addObjectToSceneRequest.dispatch( sunlight );
			var spotlight:PointLight = new PointLight();
			spotlight.x = Track.WIDTH * .5;
			spotlight.y = 700;
			spotlight.color = 0xffffff;
			spotlight.diffuse = 1;
			spotlight.specular = 1;
			spotlight.radius = 300;
			spotlight.fallOff = 4000;
			spotlight.ambient = .5;
			addLightRequest.dispatch( LightsModel.SPOTLIGHT, spotlight );
			addObjectToSceneRequest.dispatch( spotlight );
			
			// Set up lighting and materials methods.
			var specularMethod:FresnelSpecularMethod = new FresnelSpecularMethod();
			lightsModel.lightPicker = new StaticLightPicker( [ spotlight, sunlight ] );
			lightsModel.shadowMethod = new SoftShadowMapMethod( sunlight );
			materialsModel.lightPicker = lightsModel.lightPicker;
			materialsModel.shadowMethod = lightsModel.shadowMethod;
			materialsModel.specular = .25;
			materialsModel.gloss = 20;
			materialsModel.fogMethod = new FogMethod( Track.FOG_NEAR, Track.FOG_FAR, World.BACKGROUND_COLOR );
			
			Materials.DEBUG_BLOCK.lightPicker = lightsModel.lightPicker;
			Materials.DEBUG_BLOCK.shadowMethod = lightsModel.shadowMethod;
			Materials.DEBUG_BLOCK.specular = materialsModel.specular;
			Materials.DEBUG_BLOCK.gloss = materialsModel.gloss;
			Materials.DEBUG_BLOCK.specularMethod = specularMethod;
			Materials.DEBUG_BLOCK.addMethod( materialsModel.fogMethod );
			
			Materials.DEBUG_TEST.lightPicker = lightsModel.lightPicker;
			Materials.DEBUG_TEST.shadowMethod = lightsModel.shadowMethod;
			Materials.DEBUG_TEST.specular = materialsModel.specular;
			Materials.DEBUG_TEST.gloss = materialsModel.gloss;
			Materials.DEBUG_TEST.specularMethod = specularMethod;
			Materials.DEBUG_TEST.addMethod( materialsModel.fogMethod );
			
			// Light materials.
			for ( var i:int = 0; i < blockStylesModel.numStyles; i++ ) {
				var style:BlockStyleVo = blockStylesModel.getStyleAt( i );
				for ( var j:int = 0; j < style.length; j++ ) {
					var mesh:Mesh = style.getMeshAt( j );
					var material:TextureMaterial = mesh.material as TextureMaterial;
					material.shadowMethod = lightsModel.shadowMethod;
					material.lightPicker = lightsModel.lightPicker;
					material.specular = materialsModel.specular;
					material.gloss = materialsModel.gloss;
					material.specularMethod = specularMethod;
					material.addMethod( materialsModel.fogMethod );
					addObjectToSceneRequest.dispatch( mesh );
					removeObjectFromSceneRequest.dispatch( mesh );
				}
			}
			
			// Set up player to track.
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
			playerModel.mesh = new Mesh( new Geometry() );
			addObjectToSceneRequest.dispatch( playerModel.mesh );
		}
	}
}
