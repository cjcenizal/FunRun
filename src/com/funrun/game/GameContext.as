package com.funrun.game {

	import com.funrun.game.controller.commands.AddCameraCommand;
	import com.funrun.game.controller.commands.AddFloorsCommand;
	import com.funrun.game.controller.commands.AddLightCommand;
	import com.funrun.game.controller.commands.AddMaterialCommand;
	import com.funrun.game.controller.commands.AddObstacleCommand;
	import com.funrun.game.controller.commands.AddPlayerCommand;
	import com.funrun.game.controller.commands.BuildGameCommand;
	import com.funrun.game.controller.commands.BuildTimeCommand;
	import com.funrun.game.controller.commands.InternalShowMainMenuCommand;
	import com.funrun.game.controller.commands.KillPlayerCommand;
	import com.funrun.game.controller.commands.LoadBlocksCommand;
	import com.funrun.game.controller.commands.LoadFloorsCommand;
	import com.funrun.game.controller.commands.LoadObstaclesCommand;
	import com.funrun.game.controller.commands.ResetGameCommand;
	import com.funrun.game.controller.commands.StartGameCommand;
	import com.funrun.game.controller.commands.StopGameCommand;
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddCameraFulfilled;
	import com.funrun.game.controller.events.AddFloorsRequest;
	import com.funrun.game.controller.events.AddLightRequest;
	import com.funrun.game.controller.events.AddMaterialRequest;
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.AddPlayerRequest;
	import com.funrun.game.controller.events.AddTrackViewFulfilled;
	import com.funrun.game.controller.events.BuildGameRequest;
	import com.funrun.game.controller.events.BuildTimeRequest;
	import com.funrun.game.controller.events.InternalShowMainMenuRequest;
	import com.funrun.game.controller.events.KillPlayerRequest;
	import com.funrun.game.controller.events.LoadBlocksRequest;
	import com.funrun.game.controller.events.LoadFloorsRequest;
	import com.funrun.game.controller.events.LoadObstaclesRequest;
	import com.funrun.game.controller.events.ResetGameRequest;
	import com.funrun.game.controller.events.StartGameRequest;
	import com.funrun.game.controller.events.StopGameRequest;
	import com.funrun.game.controller.signals.UpdateCountdownRequest;
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.CountdownModel;
	import com.funrun.game.model.DistanceModel;
	import com.funrun.game.model.FloorsModel;
	import com.funrun.game.model.GameModel;
	import com.funrun.game.model.GeosMockModel;
	import com.funrun.game.model.IGeosModel;
	import com.funrun.game.model.LightsModel;
	import com.funrun.game.model.MaterialsModel;
	import com.funrun.game.model.ObstaclesModel;
	import com.funrun.game.model.PlayerModel;
	import com.funrun.game.model.TimeModel;
	import com.funrun.game.model.TrackModel;
	import com.funrun.game.services.BlocksJsonService;
	import com.funrun.game.services.ObstaclesJsonService;
	import com.funrun.game.view.components.CountdownView;
	import com.funrun.game.view.components.DistanceView;
	import com.funrun.game.view.components.TrackView;
	import com.funrun.game.view.mediators.CountdownMediator;
	import com.funrun.game.view.mediators.DistanceMediator;
	import com.funrun.game.view.mediators.TrackMediator;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.utilities.modularsignals.ModularSignalContext;

	public class GameContext extends ModularSignalContext {

		public function GameContext( contextView:DisplayObjectContainer ) {
			super( contextView );
		}

		override public function startup():void {
			// Set our launch configuration.
			injector.mapValue( GameType, GameType.Local, "gameType" );

			// Map services.
			injector.mapSingleton( BlocksJsonService );
			injector.mapSingleton( ObstaclesJsonService );

			// Map models.
			injector.mapSingletonOf( IGeosModel, GeosMockModel );
			injector.mapSingleton( BlocksModel );
			injector.mapSingleton( ObstaclesModel );
			injector.mapSingleton( MaterialsModel );
			injector.mapSingleton( LightsModel );
			injector.mapSingleton( TimeModel );
			injector.mapSingleton( TrackModel );
			injector.mapSingleton( PlayerModel );
			injector.mapSingleton( CameraModel );
			injector.mapSingleton( FloorsModel );
			injector.mapSingleton( DistanceModel );
			injector.mapSingleton( GameModel );
			injector.mapSingleton( CountdownModel );

			// Map signals.
			injector.mapSingleton( UpdateCountdownRequest );
			
			// Map events to commands.
			commandMap.mapEvent( BuildTimeRequest.BUILD_TIME_REQUESTED, BuildTimeCommand, BuildTimeRequest, true );
			commandMap.mapEvent( BuildGameRequest.BUILD_GAME_REQUESTED, BuildGameCommand, BuildGameRequest, true );
			commandMap.mapEvent( LoadBlocksRequest.LOAD_BLOCKS_REQUESTED, LoadBlocksCommand, LoadBlocksRequest );
			commandMap.mapEvent( LoadObstaclesRequest.LOAD_OBSTACLES_REQUESTED, LoadObstaclesCommand, LoadObstaclesRequest );
			commandMap.mapEvent( LoadFloorsRequest.LOAD_FLOORS_REQUESTED, LoadFloorsCommand, LoadFloorsRequest );
			commandMap.mapEvent( AddObstacleRequest.ADD_OBSTACLE_REQUESTED, AddObstacleCommand, AddObstacleRequest );
			commandMap.mapEvent( AddLightRequest.ADD_LIGHT_REQUESTED, AddLightCommand, AddLightRequest );
			commandMap.mapEvent( AddMaterialRequest.ADD_MATERIAL_REQUESTED, AddMaterialCommand, AddMaterialRequest );
			commandMap.mapEvent( AddPlayerRequest.ADD_PLAYER_REQUESTED, AddPlayerCommand, AddPlayerRequest );
			commandMap.mapEvent( AddFloorsRequest.ADD_FLOORS_REQUESTED, AddFloorsCommand, AddFloorsRequest );
			commandMap.mapEvent( AddCameraFulfilled.ADD_CAMERA_FULFILLED, AddCameraCommand, AddCameraFulfilled );
			commandMap.mapEvent( KillPlayerRequest.KILL_PLAYER_REQUESTED, KillPlayerCommand, KillPlayerRequest );
			commandMap.mapEvent( ResetGameRequest.RESET_GAME_REQUESTED, ResetGameCommand, ResetGameRequest );
			commandMap.mapEvent( StartGameRequest.START_GAME_REQUESTED, StartGameCommand, StartGameRequest );
			commandMap.mapEvent( StopGameRequest.STOP_GAME_REQUESTED, StopGameCommand, StopGameRequest );
			commandMap.mapEvent( InternalShowMainMenuRequest.INTERNAL_SHOW_MAIN_MENU_REQUESTED, InternalShowMainMenuCommand, InternalShowMainMenuRequest );

			// Map views to mediators.
			mediatorMap.mapView( GameModule, GameMediator );
			mediatorMap.mapView( TrackView, TrackMediator );
			mediatorMap.mapView( DistanceView, DistanceMediator );
			mediatorMap.mapView( CountdownView, CountdownMediator );

			// Let's throw some logic into this baby.
			eventDispatcher.addEventListener( AddTrackViewFulfilled.ADD_TRACK_FULFILLED, onAddTrackFulfilled );

			super.startup();
		}

		private function onAddTrackFulfilled( e:AddTrackViewFulfilled ):void {
			// TO-DO: Can this be moved inside of GameMediator, or TrackMediator?
			eventDispatcher.dispatchEvent( new BuildGameRequest( BuildGameRequest.BUILD_GAME_REQUESTED ) );
		}
	}
}
