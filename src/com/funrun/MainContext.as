package com.funrun {

	import com.funrun.controller.commands.AddCameraCommand;
	import com.funrun.controller.commands.AddFloorsCommand;
	import com.funrun.controller.commands.AddLightCommand;
	import com.funrun.controller.commands.AddMaterialCommand;
	import com.funrun.controller.commands.AddObstacleCommand;
	import com.funrun.controller.commands.AddPlayerCommand;
	import com.funrun.controller.commands.BuildGameCommand;
	import com.funrun.controller.commands.BuildTimeCommand;
	import com.funrun.controller.commands.BuildWhitelistCommand;
	import com.funrun.controller.commands.InitAppCommand;
	import com.funrun.controller.commands.KillPlayerCommand;
	import com.funrun.controller.commands.LoadBlocksCommand;
	import com.funrun.controller.commands.LoadConfigurationCommand;
	import com.funrun.controller.commands.LoadFloorsCommand;
	import com.funrun.controller.commands.LoadObstaclesCommand;
	import com.funrun.controller.commands.LoginCommand;
	import com.funrun.controller.commands.LoginFailedCommand;
	import com.funrun.controller.commands.LoginFulfilledCommand;
	import com.funrun.controller.commands.ResetGameCommand;
	import com.funrun.controller.commands.ResetPlayerCommand;
	import com.funrun.controller.commands.StartGameCommand;
	import com.funrun.controller.commands.StopGameCommand;
	import com.funrun.controller.commands.WhitelistFailedCommand;
	import com.funrun.controller.enum.GameType;
	import com.funrun.controller.events.AddCameraFulfilled;
	import com.funrun.controller.events.AddFloorsRequest;
	import com.funrun.controller.events.AddLightRequest;
	import com.funrun.controller.events.AddMaterialRequest;
	import com.funrun.controller.events.AddObstacleRequest;
	import com.funrun.controller.events.AddPlayerRequest;
	import com.funrun.controller.events.KillPlayerRequest;
	import com.funrun.controller.events.LoadBlocksRequest;
	import com.funrun.controller.events.LoadFloorsRequest;
	import com.funrun.controller.events.LoadObstaclesRequest;
	import com.funrun.controller.events.ResetGameRequest;
	import com.funrun.controller.events.StopGameRequest;
	import com.funrun.controller.signals.BuildGameRequest;
	import com.funrun.controller.signals.BuildTimeRequest;
	import com.funrun.controller.signals.BuildWhitelistRequest;
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.LoadConfigurationRequest;
	import com.funrun.controller.signals.LoginFailed;
	import com.funrun.controller.signals.LoginFulfilled;
	import com.funrun.controller.signals.LoginRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.StartGameRequest;
	import com.funrun.controller.signals.StartRunningMainMenuRequest;
	import com.funrun.controller.signals.StopRunningMainMenuRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.UpdateCountdownRequest;
	import com.funrun.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.controller.signals.WhitelistFailed;
	import com.funrun.model.BlocksModel;
	import com.funrun.model.CameraModel;
	import com.funrun.model.ConfigurationModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.FloorsModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.GeosMockModel;
	import com.funrun.model.IGeosModel;
	import com.funrun.model.LightsModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.UserModel;
	import com.funrun.services.BlocksJsonService;
	import com.funrun.services.IWhitelistService;
	import com.funrun.services.ObstaclesJsonService;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.WhitelistService;
	import com.funrun.view.components.CountdownView;
	import com.funrun.view.components.DistanceView;
	import com.funrun.view.components.GameView;
	import com.funrun.view.components.LoginStatusView;
	import com.funrun.view.components.MainMenuView;
	import com.funrun.view.components.MainView;
	import com.funrun.view.components.TrackView;
	import com.funrun.view.mediators.AppMediator;
	import com.funrun.view.mediators.CountdownMediator;
	import com.funrun.view.mediators.DistanceMediator;
	import com.funrun.view.mediators.GameMediator;
	import com.funrun.view.mediators.LoginStatusMediator;
	import com.funrun.view.mediators.MainMediator;
	import com.funrun.view.mediators.MainMenuMediator;
	import com.funrun.view.mediators.TrackMediator;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import org.robotlegs.mvcs.SignalContext;

	public class MainContext extends SignalContext {

		public function MainContext( contextView:DisplayObjectContainer, autoStartup:Boolean ) {
			super( contextView, autoStartup );
		}

		override public function startup():void {
			// Set our launch configuration.
			injector.mapValue( GameType, GameType.Local, "gameType" );

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
			injector.mapSingleton( ConfigurationModel );
			injector.mapSingleton( UserModel );
			
			// Map services.
			injector.mapSingleton( BlocksJsonService );
			injector.mapSingleton( ObstaclesJsonService );
			injector.mapSingleton( PlayerioFacebookLoginService );
			injector.mapSingletonOf( IWhitelistService, WhitelistService ); // TO-DO: Use a variable to toggle between open and regular.
			
			// Map signals.
			injector.mapSingleton( UpdateCountdownRequest );
			injector.mapSingleton( ToggleCountdownRequest );
			injector.mapSingleton( StopRunningMainMenuRequest );
			injector.mapSingleton( StartRunningMainMenuRequest );
			injector.mapSingleton( EnableMainMenuRequest );
			injector.mapSingleton( UpdateLoginStatusRequest );
			injector.mapSingleton( ShowScreenRequest );
			signalCommandMap.mapSignalClass( BuildWhitelistRequest,					BuildWhitelistCommand );
			signalCommandMap.mapSignalClass( LoadConfigurationRequest, 				LoadConfigurationCommand );
			signalCommandMap.mapSignalClass( LoginRequest,							LoginCommand );
			signalCommandMap.mapSignalClass( LoginFailed,							LoginFailedCommand );
			signalCommandMap.mapSignalClass( LoginFulfilled,						LoginFulfilledCommand );
			signalCommandMap.mapSignalClass( WhitelistFailed,						WhitelistFailedCommand );
			signalCommandMap.mapSignalClass( ResetPlayerRequest, 					ResetPlayerCommand );
			signalCommandMap.mapSignalClass( StartGameRequest,						StartGameCommand );
			signalCommandMap.mapSignalClass( BuildTimeRequest,						BuildTimeCommand );
			signalCommandMap.mapSignalClass( BuildGameRequest,						BuildGameCommand );
			
			// Map events to commands.
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
			commandMap.mapEvent( StopGameRequest.STOP_GAME_REQUESTED, StopGameCommand, StopGameRequest );

			// Map views to mediators.
			mediatorMap.mapView( MainView, 				MainMediator );
			mediatorMap.mapView( TrackView, 			TrackMediator );
			mediatorMap.mapView( DistanceView, 			DistanceMediator );
			mediatorMap.mapView( CountdownView, 		CountdownMediator );
			mediatorMap.mapView( LoginStatusView, 		LoginStatusMediator );
			mediatorMap.mapView( GameView,				GameMediator );
			mediatorMap.mapView( MainMenuView,			MainMenuMediator );
			
			// Do this last, since it causes our entire view system to be built.
			mediatorMap.mapView( FunRun, 				AppMediator );
			
			// Kick everything off one frame later.
			this.contextView.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			super.startup();
		}

		private function onEnterFrame( e:Event ):void {
			this.contextView.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			commandMap.execute( InitAppCommand );
		}
	}
}
