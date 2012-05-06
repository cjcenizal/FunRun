package com.funrun.game
{
	
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	
	import com.funrun.game.controller.commands.AddLightCommand;
	import com.funrun.game.controller.commands.AddMaterialCommand;
	import com.funrun.game.controller.commands.AddObstacleCommand;
	import com.funrun.game.controller.commands.BuildGameCommand;
	import com.funrun.game.controller.commands.LoadBlocksCommand;
	import com.funrun.game.controller.commands.LoadObstaclesCommand;
	import com.funrun.game.controller.commands.StartGameCommand;
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddLightRequest;
	import com.funrun.game.controller.events.AddMaterialRequest;
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.BuildGameRequest;
	import com.funrun.game.controller.events.LoadBlocksRequest;
	import com.funrun.game.controller.events.LoadObstaclesRequest;
	import com.funrun.game.controller.events.StartGameRequest;
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.DummyGeosModel;
	import com.funrun.game.model.IGeosModel;
	import com.funrun.game.model.LightsModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.services.BlocksJsonService;
	import com.funrun.game.services.ObstaclesJsonService;
	import com.funrun.game.view.components.TrackView;
	import com.funrun.game.view.mediators.TrackMediator;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;
	
	public class GameContext extends ModuleContext
	{
		
		public function GameContext( contextView:DisplayObjectContainer ) {
			super( contextView );
		}
		
		override public function startup():void {
			// Launch configuration.
			injector.mapValue( GameType, GameType.Local, "gameType" );
			
			// This stuff might jsut be temp.
			injector.mapSingletonOf( BlocksJsonService, BlocksJsonService );
			injector.mapSingletonOf( ObstaclesJsonService, ObstaclesJsonService );
			
			// Misc essential injections.
			injector.mapValue( Stage, contextView.stage );
			injector.mapSingletonOf( BlocksModel, BlocksModel );
			injector.mapSingletonOf( ObstaclesModel, ObstaclesModel );
			injector.mapSingletonOf( MaterialsModel, MaterialsModel );
			injector.mapSingletonOf( LightsModel, LightsModel );
			injector.mapSingletonOf( IGeosModel, DummyGeosModel );
			mediatorMap.mapView( TrackView, TrackMediator );
			
			// Controller.
			commandMap.mapEvent( BuildGameRequest.BUILD_GAME_REQUESTED, 		BuildGameCommand, 		BuildGameRequest, true );
			commandMap.mapEvent( LoadBlocksRequest.LOAD_BLOCKS_REQUESTED, 		LoadBlocksCommand, 		LoadBlocksRequest, true );
			commandMap.mapEvent( LoadObstaclesRequest.LOAD_OBSTACLES_REQUESTED, LoadObstaclesCommand, 	LoadObstaclesRequest, true );
			commandMap.mapEvent( AddObstacleRequest.ADD_OBSTACLE_REQUESTED, 	AddObstacleCommand, 	AddObstacleRequest );
			commandMap.mapEvent( AddLightRequest.ADD_LIGHT_REQUESTED, 			AddLightCommand, 		AddLightRequest );
			commandMap.mapEvent( AddMaterialRequest.ADD_MATERIAL_REQUESTED, 	AddMaterialCommand, 	AddMaterialRequest );
			commandMap.mapEvent( StartGameRequest.START_GAME_REQUESTED, 		StartGameCommand, 		StartGameRequest );
			
			// View.
			mediatorMap.mapView( GameModule, GameMediator );
			
			super.startup();
			
			// Load stuff.
			eventDispatcher.dispatchEvent( new LoadBlocksRequest( LoadBlocksRequest.LOAD_BLOCKS_REQUESTED ) );
			eventDispatcher.dispatchEvent( new LoadObstaclesRequest( LoadObstaclesRequest.LOAD_OBSTACLES_REQUESTED ) );
			
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
			eventDispatcher.dispatchEvent( new AddLightRequest( AddLightRequest.ADD_LIGHT_REQUESTED, LightsModel.SUN, sun ) );
			eventDispatcher.dispatchEvent( new AddLightRequest( AddLightRequest.ADD_LIGHT_REQUESTED, LightsModel.SPOTLIGHT, spotlight ) );
			
			// Add materials.
			eventDispatcher.dispatchEvent( new AddMaterialRequest( AddMaterialRequest.ADD_MATERIAL_REQUESTED, MaterialsModel.PLAYER_MATERIAL, new ColorMaterial( 0x00FF00 ) ) );
			eventDispatcher.dispatchEvent( new AddMaterialRequest( AddMaterialRequest.ADD_MATERIAL_REQUESTED, MaterialsModel.GROUND_MATERIAL, new ColorMaterial( 0xFF0000 ) ) );
			eventDispatcher.dispatchEvent( new AddMaterialRequest( AddMaterialRequest.ADD_MATERIAL_REQUESTED, MaterialsModel.OBSTACLE_MATERIAL, new ColorMaterial( 0x0000FF ) ) );
		}
	}
}
