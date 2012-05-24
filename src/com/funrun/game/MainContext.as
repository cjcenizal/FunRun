package com.funrun.game {

	import com.funrun.game.controller.commands.AddCameraCommand;
	import com.funrun.game.controller.commands.AddFloorsCommand;
	import com.funrun.game.controller.commands.AddLightCommand;
	import com.funrun.game.controller.commands.AddMaterialCommand;
	import com.funrun.game.controller.commands.AddObstacleCommand;
	import com.funrun.game.controller.commands.AddPlayerCommand;
	import com.funrun.game.controller.commands.BuildGameCommand;
	import com.funrun.game.controller.commands.BuildTimeCommand;
	import com.funrun.game.controller.commands.BuildWhitelistCommand;
	import com.funrun.game.controller.commands.InitAppCommand;
	import com.funrun.game.controller.commands.InternalShowMainMenuCommand;
	import com.funrun.game.controller.commands.KillPlayerCommand;
	import com.funrun.game.controller.commands.LoadBlocksCommand;
	import com.funrun.game.controller.commands.LoadConfigurationCommand;
	import com.funrun.game.controller.commands.LoadFloorsCommand;
	import com.funrun.game.controller.commands.LoadObstaclesCommand;
	import com.funrun.game.controller.commands.LoginCommand;
	import com.funrun.game.controller.commands.LoginFailedCommand;
	import com.funrun.game.controller.commands.LoginFulfilledCommand;
	import com.funrun.game.controller.commands.ResetGameCommand;
	import com.funrun.game.controller.commands.ResetPlayerCommand;
	import com.funrun.game.controller.commands.ShowMainMenuCommand;
	import com.funrun.game.controller.commands.StartGameCommand;
	import com.funrun.game.controller.commands.StopGameCommand;
	import com.funrun.game.controller.commands.ToggleMainMenuCommand;
	import com.funrun.game.controller.commands.WhitelistFailedCommand;
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddCameraFulfilled;
	import com.funrun.game.controller.events.AddFloorsRequest;
	import com.funrun.game.controller.events.AddLightRequest;
	import com.funrun.game.controller.events.AddMaterialRequest;
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.AddPlayerRequest;
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
	import com.funrun.game.controller.signals.BuildWhitelistRequest;
	import com.funrun.game.controller.signals.DisableMainMenuOptionsRequest;
	import com.funrun.game.controller.signals.EnableMainMenuOptionsRequest;
	import com.funrun.game.controller.signals.LoadConfigurationRequest;
	import com.funrun.game.controller.signals.LoginFailed;
	import com.funrun.game.controller.signals.LoginFulfilled;
	import com.funrun.game.controller.signals.LoginRequest;
	import com.funrun.game.controller.signals.ResetPlayerRequest;
	import com.funrun.game.controller.signals.ShowMainModuleRequest;
	import com.funrun.game.controller.signals.StartRunningMainMenuRequest;
	import com.funrun.game.controller.signals.StopRunningMainMenuRequest;
	import com.funrun.game.controller.signals.ToggleCountdownRequest;
	import com.funrun.game.controller.signals.ToggleMainMenuOptionsRequest;
	import com.funrun.game.controller.signals.UpdateCountdownRequest;
	import com.funrun.game.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.game.controller.signals.WhitelistFailed;
	import com.funrun.game.model.BlocksModel;
	import com.funrun.game.model.CameraModel;
	import com.funrun.game.model.ConfigurationModel;
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
	import com.funrun.game.model.UserModel;
	import com.funrun.game.services.BlocksJsonService;
	import com.funrun.game.services.IWhitelistService;
	import com.funrun.game.services.ObstaclesJsonService;
	import com.funrun.game.services.PlayerioFacebookLoginService;
	import com.funrun.game.services.WhitelistService;
	import com.funrun.game.view.components.CountdownView;
	import com.funrun.game.view.components.DistanceView;
	import com.funrun.game.view.components.GameView;
	import com.funrun.game.view.components.LoginStatusView;
	import com.funrun.game.view.components.MainMenuView;
	import com.funrun.game.view.components.TrackView;
	import com.funrun.game.view.mediators.AppMediator;
	import com.funrun.game.view.mediators.CountdownMediator;
	import com.funrun.game.view.mediators.DistanceMediator;
	import com.funrun.game.view.mediators.GameMediator;
	import com.funrun.game.view.mediators.LoginStatusMediator;
	import com.funrun.game.view.mediators.MainMenuMediator;
	import com.funrun.game.view.mediators.TrackMediator;
	
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
			injector.mapSingleton( ConfigurationModel );
			injector.mapSingleton( UserModel );
			
			// Map services.
			injector.mapSingleton( PlayerioFacebookLoginService );
			injector.mapSingletonOf( IWhitelistService, WhitelistService ); // TO-DO: Use a variable to toggle between open and regular.
			
			// Map signals.
			injector.mapSingleton( UpdateCountdownRequest );
			injector.mapSingleton( ToggleCountdownRequest );
			injector.mapSingleton( StopRunningMainMenuRequest );
			injector.mapSingleton( StartRunningMainMenuRequest );
			injector.mapSingleton( EnableMainMenuOptionsRequest );
			injector.mapSingleton( DisableMainMenuOptionsRequest );
			injector.mapSingleton( UpdateLoginStatusRequest );
			signalCommandMap.mapSignalClass( BuildWhitelistRequest,					BuildWhitelistCommand );
			signalCommandMap.mapSignalClass( LoadConfigurationRequest, 				LoadConfigurationCommand );
			signalCommandMap.mapSignalClass( LoginRequest,							LoginCommand );
			signalCommandMap.mapSignalClass( LoginFailed,							LoginFailedCommand );
			signalCommandMap.mapSignalClass( LoginFulfilled,						LoginFulfilledCommand );
			signalCommandMap.mapSignalClass( WhitelistFailed,						WhitelistFailedCommand );
			signalCommandMap.mapSignalClass( ShowMainModuleRequest, 				ShowMainMenuCommand );
			signalCommandMap.mapSignalClass( ToggleMainMenuOptionsRequest, 			ToggleMainMenuCommand );
			signalCommandMap.mapSignalClass( ResetPlayerRequest, 					ResetPlayerCommand );
			
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
			mediatorMap.mapView( MainView, 				MainMediator );
			mediatorMap.mapView( TrackView, 			TrackMediator );
			mediatorMap.mapView( DistanceView, 			DistanceMediator );
			mediatorMap.mapView( CountdownView, 		CountdownMediator );
			mediatorMap.mapView( LoginStatusView, 		LoginStatusMediator );
			mediatorMap.mapView( GameView,				GameMediator );
			mediatorMap.mapView( MainMenuView,			MainMenuMediator );
			
			// Do this last, since it causes our entire view system to be built.
			mediatorMap.mapView( FunRun, 				AppMediator );
			
			// Let's throw some logic into this baby.
			//eventDispatcher.addEventListener( AddTrackViewFulfilled.ADD_TRACK_FULFILLED, onAddTrackFulfilled );
			// Kick everything off one frame later.
			//this.contextView.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			super.startup();
		}

		private function onEnterFrame( e:Event ):void {
			this.contextView.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			commandMap.execute( InitAppCommand );
		}
		/*
		private function onAddTrackFulfilled( e:AddTrackViewFulfilled ):void {
			// TO-DO: Can this be moved inside of GameMediator, or TrackMediator?
			eventDispatcher.dispatchEvent( new BuildGameRequest( BuildGameRequest.BUILD_GAME_REQUESTED ) );
		}*/
	}
}
