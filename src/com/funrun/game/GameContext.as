package com.funrun.game
{
	
	import com.funrun.game.controller.commands.AddCameraCommand;
	import com.funrun.game.controller.commands.AddLightCommand;
	import com.funrun.game.controller.commands.AddMaterialCommand;
	import com.funrun.game.controller.commands.AddObstacleCommand;
	import com.funrun.game.controller.commands.AddPlayerCommand;
	import com.funrun.game.controller.commands.BuildGameCommand;
	import com.funrun.game.controller.commands.BuildTimeCommand;
	import com.funrun.game.controller.commands.LoadBlocksCommand;
	import com.funrun.game.controller.commands.LoadObstaclesCommand;
	import com.funrun.game.controller.commands.StartGameCommand;
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddCameraFulfilled;
	import com.funrun.game.controller.events.AddLightRequest;
	import com.funrun.game.controller.events.AddMaterialRequest;
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.AddPlayerRequest;
	import com.funrun.game.controller.events.AddTrackFulfilled;
	import com.funrun.game.controller.events.BuildGameRequest;
	import com.funrun.game.controller.events.BuildTimeRequest;
	import com.funrun.game.controller.events.LoadBlocksRequest;
	import com.funrun.game.controller.events.LoadObstaclesRequest;
	import com.funrun.game.controller.events.StartGameRequest;
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.DummyGeosModel;
	import com.funrun.game.model.IGeosModel;
	import com.funrun.game.model.LightsModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.TimeModel;
	import com.funrun.game.model.TrackModel;
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
			injector.mapSingletonOf( TimeModel, TimeModel );
			injector.mapSingletonOf( TrackModel, TrackModel );
			injector.mapSingletonOf( PlayerModel, PlayerModel );
			injector.mapSingletonOf( CameraModel, CameraModel );
			
			// Controller.
			commandMap.mapEvent( BuildTimeRequest.BUILD_TIME_REQUESTED, 		BuildTimeCommand, 		BuildTimeRequest, true );
			commandMap.mapEvent( BuildGameRequest.BUILD_GAME_REQUESTED, 		BuildGameCommand, 		BuildGameRequest, true );
			commandMap.mapEvent( LoadBlocksRequest.LOAD_BLOCKS_REQUESTED, 		LoadBlocksCommand, 		LoadBlocksRequest, true );
			commandMap.mapEvent( LoadObstaclesRequest.LOAD_OBSTACLES_REQUESTED, LoadObstaclesCommand, 	LoadObstaclesRequest, true );
			commandMap.mapEvent( AddObstacleRequest.ADD_OBSTACLE_REQUESTED, 	AddObstacleCommand, 	AddObstacleRequest );
			commandMap.mapEvent( AddLightRequest.ADD_LIGHT_REQUESTED, 			AddLightCommand, 		AddLightRequest );
			commandMap.mapEvent( AddMaterialRequest.ADD_MATERIAL_REQUESTED, 	AddMaterialCommand, 	AddMaterialRequest );
			commandMap.mapEvent( StartGameRequest.START_GAME_REQUESTED, 		StartGameCommand, 		StartGameRequest );
			commandMap.mapEvent( AddPlayerRequest.ADD_PLAYER_REQUESTED, 		AddPlayerCommand, 		AddPlayerRequest );
			commandMap.mapEvent( AddCameraFulfilled.ADD_CAMERA_FULFILLED,		AddCameraCommand,		AddCameraFulfilled );
			
			// View.
			mediatorMap.mapView( TrackView, TrackMediator );
			mediatorMap.mapView( GameModule, GameMediator );
			
			// Let's have some logic in this baby.
			eventDispatcher.addEventListener( AddTrackFulfilled.ADD_TRACK_FULFILLED, onAddTrackFulfilled );
			
			super.startup();
		}
		
		private function onAddTrackFulfilled( e:AddTrackFulfilled ):void {
			eventDispatcher.dispatchEvent( new BuildGameRequest( BuildGameRequest.BUILD_GAME_REQUESTED ) );
			eventDispatcher.dispatchEvent( new StartGameRequest( StartGameRequest.START_GAME_REQUESTED ) );
		}
	}
}
