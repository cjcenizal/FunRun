package com.funrun.game
{
	
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	
	import com.funrun.game.controller.commands.AddLightCommand;
	import com.funrun.game.controller.commands.AddMaterialCommand;
	import com.funrun.game.controller.commands.AddObstacleCommand;
	import com.funrun.game.controller.commands.BuildGameCommand;
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddLightRequest;
	import com.funrun.game.controller.events.AddMaterialRequest;
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.BuildGameRequest;
	import com.funrun.game.model.GeosModel;
	import com.funrun.game.model.LightsModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.ObstaclesModel;
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
			
			// Misc essential injections.
			injector.mapValue( Stage, contextView.stage );
			injector.mapSingletonOf( GeosModel, GeosModel );
			injector.mapSingletonOf( ObstaclesModel, ObstaclesModel );
			injector.mapSingletonOf( MaterialsModel, MaterialsModel );
			injector.mapSingletonOf( LightsModel, LightsModel );
			mediatorMap.mapView( TrackView, TrackMediator );
			
			// Controller.
			commandMap.mapEvent( BuildGameRequest.BUILD_GAME_REQUESTED, BuildGameCommand, BuildGameRequest, true );
			commandMap.mapEvent( AddObstacleRequest.ADD_OBSTACLE_REQUESTED, AddObstacleCommand, AddObstacleRequest );
			commandMap.mapEvent( AddLightRequest.ADD_LIGHT_REQUESTED, AddLightCommand, AddLightRequest );
			commandMap.mapEvent( AddMaterialRequest.ADD_MATERIAL_REQUESTED, AddMaterialCommand, AddMaterialRequest );
			
			// View.
			mediatorMap.mapView( GameModule, GameMediator );
			
			super.startup();
			
			// Add lights.
			var sun:DirectionalLight = new DirectionalLight( .5, -1, 0 );
			sun.ambient = .1;
			sun.z = 2000;
			var spotlight:PointLight = new PointLight();
			spotlight.castsShadows = true;
			spotlight.shadowMapper.depthMapSize = 1024;
			spotlight.y = 120;
			spotlight.color = 0xffffff;
			spotlight.diffuse = 1;
			spotlight.specular = 1;
			spotlight.radius = 400;
			spotlight.fallOff = 1000;
			spotlight.ambient = 0xa0a0c0;
			spotlight.ambient = .5;
			eventDispatcher.dispatchEvent( new AddLightRequest( AddLightRequest.ADD_LIGHT_REQUESTED, LightsModel.SUN, sun ) );
			eventDispatcher.dispatchEvent( new AddLightRequest( AddLightRequest.ADD_LIGHT_REQUESTED, LightsModel.SPOTLIGHT, spotlight ) );
			
			// Add materials.
			eventDispatcher.dispatchEvent( new AddMaterialRequest( AddMaterialRequest.ADD_MATERIAL_REQUESTED, MaterialsModel.PLAYER_MATERIAL, new ColorMaterial( 0x00FF00 ) ) );
			eventDispatcher.dispatchEvent( new AddMaterialRequest( AddMaterialRequest.ADD_MATERIAL_REQUESTED, MaterialsModel.GROUND_MATERIAL, new ColorMaterial( 0xFF0000 ) ) );
			eventDispatcher.dispatchEvent( new AddMaterialRequest( AddMaterialRequest.ADD_MATERIAL_REQUESTED, MaterialsModel.OBSTACLE_MATERIAL, new ColorMaterial( 0x0000FF ) ) );
			
			// Assign materials to track.
			eventDispatcher.dispatchEvent( new BuildGameRequest( BuildGameRequest.BUILD_GAME_REQUESTED ) );
			
		}
	}
}
