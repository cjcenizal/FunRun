package com.funrun {

	import com.funrun.controller.commands.AddFloorCommand;
	import com.funrun.controller.commands.AddLightCommand;
	import com.funrun.controller.commands.AddMaterialCommand;
	import com.funrun.controller.commands.AddObstacleCommand;
	import com.funrun.controller.commands.AddPlayerCommand;
	import com.funrun.controller.commands.BuildGameCommand;
	import com.funrun.controller.commands.BuildTimeCommand;
	import com.funrun.controller.commands.BuildWhitelistCommand;
	import com.funrun.controller.commands.ConnectMultiplayerCommand;
	import com.funrun.controller.commands.InitAppCommand;
	import com.funrun.controller.commands.KeyDownCommand;
	import com.funrun.controller.commands.KeyUpCommand;
	import com.funrun.controller.commands.KillPlayerCommand;
	import com.funrun.controller.commands.LeaveGameCommand;
	import com.funrun.controller.commands.LoadBlocksCommand;
	import com.funrun.controller.commands.LoadConfigurationCommand;
	import com.funrun.controller.commands.LoadFloorsCommand;
	import com.funrun.controller.commands.LoadObstaclesCommand;
	import com.funrun.controller.commands.LoginCommand;
	import com.funrun.controller.commands.LoginFailedCommand;
	import com.funrun.controller.commands.LoginFulfilledCommand;
	import com.funrun.controller.commands.ResetGameCommand;
	import com.funrun.controller.commands.ResetPlayerCommand;
	import com.funrun.controller.commands.ShowFindingGamePopupCommand;
	import com.funrun.controller.commands.ShowPlayerioErrorPopupCommand;
	import com.funrun.controller.commands.ShowResultsPopupCommand;
	import com.funrun.controller.commands.StartGameCommand;
	import com.funrun.controller.commands.StartRunningCommand;
	import com.funrun.controller.commands.StopGameCommand;
	import com.funrun.controller.commands.WhitelistFailedCommand;
	import com.funrun.controller.signals.AddCameraRequest;
	import com.funrun.controller.signals.AddFloorRequest;
	import com.funrun.controller.signals.AddLightRequest;
	import com.funrun.controller.signals.AddMaterialRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddObstacleRequest;
	import com.funrun.controller.signals.AddPlayerRequest;
	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.controller.signals.BuildGameRequest;
	import com.funrun.controller.signals.BuildTimeRequest;
	import com.funrun.controller.signals.BuildWhitelistRequest;
	import com.funrun.controller.signals.ConnectMultiplayerRequest;
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.LeaveGameRequest;
	import com.funrun.controller.signals.LoadBlocksRequest;
	import com.funrun.controller.signals.LoadConfigurationRequest;
	import com.funrun.controller.signals.LoadFloorsRequest;
	import com.funrun.controller.signals.LoadObstaclesRequest;
	import com.funrun.controller.signals.LoginFailed;
	import com.funrun.controller.signals.LoginFulfilled;
	import com.funrun.controller.signals.LoginRequest;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.RemovePopupRequest;
	import com.funrun.controller.signals.RemoveResultsPopupRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.ResetGameRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.controller.signals.ShowFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.controller.signals.ShowResultsPopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.StartGameRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.controller.signals.StopGameRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.UpdateCountdownRequest;
	import com.funrun.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.controller.signals.WhitelistFailed;
	import com.funrun.model.BlocksModel;
	import com.funrun.model.CameraModel;
	import com.funrun.model.CompetitorsModel;
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
	import com.funrun.services.PlayerioMultiplayerService;
	import com.funrun.services.WhitelistService;
	import com.funrun.view.components.CountdownView;
	import com.funrun.view.components.DistanceView;
	import com.funrun.view.components.FindingGamePopup;
	import com.funrun.view.components.GameView;
	import com.funrun.view.components.LoginStatusView;
	import com.funrun.view.components.MainMenuView;
	import com.funrun.view.components.MainView;
	import com.funrun.view.components.PlayerioErrorPopupView;
	import com.funrun.view.components.PopupsView;
	import com.funrun.view.components.ResultsPopup;
	import com.funrun.view.components.TrackView;
	import com.funrun.view.mediators.AppMediator;
	import com.funrun.view.mediators.CountdownMediator;
	import com.funrun.view.mediators.DistanceMediator;
	import com.funrun.view.mediators.FindingGamePopupMediator;
	import com.funrun.view.mediators.GameMediator;
	import com.funrun.view.mediators.LoginStatusMediator;
	import com.funrun.view.mediators.MainMediator;
	import com.funrun.view.mediators.MainMenuMediator;
	import com.funrun.view.mediators.PlayerioErrorPopupMediator;
	import com.funrun.view.mediators.PopupsMediator;
	import com.funrun.view.mediators.ResultPopupMediator;
	import com.funrun.view.mediators.TrackMediator;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.SignalContext;

	public class MainContext extends SignalContext {

		public function MainContext( contextView:DisplayObjectContainer, autoStartup:Boolean ) {
			super( contextView, autoStartup );
		}

		override public function startup():void {
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
			injector.mapSingleton( CompetitorsModel );
			
			// Map services.
			injector.mapSingleton( BlocksJsonService );
			injector.mapSingleton( ObstaclesJsonService );
			injector.mapSingleton( PlayerioFacebookLoginService );
			injector.mapSingleton( PlayerioMultiplayerService );
			injector.mapSingletonOf( IWhitelistService, WhitelistService ); // TO-DO: Use a variable to toggle between open and regular.
			
			// Map signals.
			injector.mapSingleton( UpdateCountdownRequest );
			injector.mapSingleton( ToggleCountdownRequest );
			injector.mapSingleton( EnableMainMenuRequest );
			injector.mapSingleton( UpdateLoginStatusRequest );
			injector.mapSingleton( ShowScreenRequest );
			injector.mapSingleton( AddObjectToSceneRequest );
			injector.mapSingleton( RemoveObjectFromSceneRequest );
			injector.mapSingleton( EnablePlayerInputRequest );
			injector.mapSingleton( RenderSceneRequest );
			injector.mapSingleton( DisplayDistanceRequest );
			injector.mapSingleton( AddCameraRequest );
			injector.mapSingleton( AddPopupRequest );
			injector.mapSingleton( RemovePopupRequest );
			injector.mapSingleton( RemoveResultsPopupRequest );
			injector.mapSingleton( RemoveFindingGamePopupRequest );
			signalCommandMap.mapSignalClass( LoadBlocksRequest,						LoadBlocksCommand );
			signalCommandMap.mapSignalClass( LoadObstaclesRequest,					LoadObstaclesCommand );
			signalCommandMap.mapSignalClass( LoadFloorsRequest,						LoadFloorsCommand );
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
			signalCommandMap.mapSignalClass( AddMaterialRequest,					AddMaterialCommand );
			signalCommandMap.mapSignalClass( AddObstacleRequest,					AddObstacleCommand );
			signalCommandMap.mapSignalClass( AddLightRequest,						AddLightCommand );
			signalCommandMap.mapSignalClass( AddPlayerRequest,						AddPlayerCommand );
			signalCommandMap.mapSignalClass( AddFloorRequest,						AddFloorCommand );
			signalCommandMap.mapSignalClass( StopGameRequest,						StopGameCommand );
			signalCommandMap.mapSignalClass( ResetGameRequest,						ResetGameCommand );
			signalCommandMap.mapSignalClass( KillPlayerRequest,						KillPlayerCommand );
			signalCommandMap.mapSignalClass( ShowResultsPopupRequest,				ShowResultsPopupCommand );
			signalCommandMap.mapSignalClass( StartRunningRequest,					StartRunningCommand );
			signalCommandMap.mapSignalClass( ConnectMultiplayerRequest,				ConnectMultiplayerCommand );
			signalCommandMap.mapSignalClass( ShowFindingGamePopupRequest,			ShowFindingGamePopupCommand );
			signalCommandMap.mapSignalClass( ShowResultsPopupRequest,				ShowResultsPopupCommand );
			signalCommandMap.mapSignalClass( LeaveGameRequest,						LeaveGameCommand );
			signalCommandMap.mapSignalClass( ShowPlayerioErrorPopupRequest,			ShowPlayerioErrorPopupCommand );
			
			// Map events to commands.
			commandMap.mapEvent( KeyboardEvent.KEY_DOWN, KeyDownCommand, KeyboardEvent );
			commandMap.mapEvent( KeyboardEvent.KEY_UP, KeyUpCommand, KeyboardEvent );

			// Map views to mediators.
			mediatorMap.mapView( MainView, 					MainMediator );
			mediatorMap.mapView( TrackView, 				TrackMediator );
			mediatorMap.mapView( DistanceView, 				DistanceMediator );
			mediatorMap.mapView( CountdownView, 			CountdownMediator );
			mediatorMap.mapView( LoginStatusView, 			LoginStatusMediator );
			mediatorMap.mapView( GameView,					GameMediator );
			mediatorMap.mapView( MainMenuView,				MainMenuMediator );
			mediatorMap.mapView( PopupsView,				PopupsMediator );
			mediatorMap.mapView( ResultsPopup,				ResultPopupMediator );
			mediatorMap.mapView( FindingGamePopup,			FindingGamePopupMediator );
			mediatorMap.mapView( PlayerioErrorPopupView,	PlayerioErrorPopupMediator );
			
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
