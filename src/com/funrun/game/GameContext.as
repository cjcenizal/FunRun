package com.funrun.game
{
	
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	
	import com.funrun.game.controller.commands.AddObstacleCommand;
	import com.funrun.game.controller.commands.StartGameCommand;
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddLightRequest;
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.StartGameRequest;
	import com.funrun.game.model.GeosModel;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.view.components.TrackView;
	import com.funrun.game.view.mediators.TrackMediator;
	import com.funrun.game.model.LightsModel;
	
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
			mediatorMap.mapView( TrackView, TrackMediator );
			
			// Controller.
			commandMap.mapEvent( StartGameRequest.START_GAME_REQUESTED, StartGameCommand, StartGameRequest, true );
			commandMap.mapEvent( AddObstacleRequest.ADD_OBSTACLE_REQUESTED, AddObstacleCommand, AddObstacleRequest, true );
			
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
			
			// Start game.
			eventDispatcher.dispatchEvent( new StartGameRequest( StartGameRequest.START_GAME_REQUESTED ) );
		}
	}
}
