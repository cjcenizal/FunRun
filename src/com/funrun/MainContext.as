package com.funrun {

	import com.funrun.controller.commands.AddCompetitorCommand;
	import com.funrun.controller.commands.AddEmptyFloorCommand;
	import com.funrun.controller.commands.AddLightCommand;
	import com.funrun.controller.commands.AddMaterialCommand;
	import com.funrun.controller.commands.AddObjectToSceneCommand;
	import com.funrun.controller.commands.AddObstacleCommand;
	import com.funrun.controller.commands.AddObstaclesCommand;
	import com.funrun.controller.commands.AddPlaceableCommand;
	import com.funrun.controller.commands.AddPlayerCommand;
	import com.funrun.controller.commands.CheckWhitelistCommand;
	import com.funrun.controller.commands.HandleMultiplayerInitCommand;
	import com.funrun.controller.commands.HandleMultiplayerJoinGameCommand;
	import com.funrun.controller.commands.HandleMultiplayerNewPlayerJoinedCommand;
	import com.funrun.controller.commands.HandleMultiplayerPlayerDiedCommand;
	import com.funrun.controller.commands.HandleMultiplayerPlayerLeftCommand;
	import com.funrun.controller.commands.HandleMultiplayerUpdateCommand;
	import com.funrun.controller.commands.InitAppCommand;
	import com.funrun.controller.commands.InitGameCommand;
	import com.funrun.controller.commands.InitModelsCommand;
	import com.funrun.controller.commands.JoinGameCommand;
	import com.funrun.controller.commands.JoinMatchmakingCommand;
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
	import com.funrun.controller.commands.RemoveCompetitorCommand;
	import com.funrun.controller.commands.RemoveObjectFromSceneCommand;
	import com.funrun.controller.commands.RemovePlaceableCommand;
	import com.funrun.controller.commands.ResetCountdownCommand;
	import com.funrun.controller.commands.ResetGameCommand;
	import com.funrun.controller.commands.ResetPlayerCommand;
	import com.funrun.controller.commands.SendMultiplayerDeathCommand;
	import com.funrun.controller.commands.SendMultiplayerUpdateCommand;
	import com.funrun.controller.commands.ShowFindingGamePopupCommand;
	import com.funrun.controller.commands.ShowPlayerioErrorPopupCommand;
	import com.funrun.controller.commands.ShowResultsPopupCommand;
	import com.funrun.controller.commands.StartCountdownCommand;
	import com.funrun.controller.commands.StartGameCommand;
	import com.funrun.controller.commands.StartGameLoopCommand;
	import com.funrun.controller.commands.StartObserverLoopCommand;
	import com.funrun.controller.commands.StartRunningCommand;
	import com.funrun.controller.commands.StopGameLoopCommand;
	import com.funrun.controller.commands.StopObserverLoopCommand;
	import com.funrun.controller.commands.UpdateCompetitorsCommand;
	import com.funrun.controller.commands.UpdateObstaclesCommand;
	import com.funrun.controller.commands.UpdatePlacesCommand;
	import com.funrun.controller.commands.UpdatePlayerCollisionsCommand;
	import com.funrun.controller.commands.WhitelistFailedCommand;
	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.AddEmptyFloorRequest;
	import com.funrun.controller.signals.AddLightRequest;
	import com.funrun.controller.signals.AddMaterialRequest;
	import com.funrun.controller.signals.AddNametagRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddObstacleRequest;
	import com.funrun.controller.signals.AddObstaclesRequest;
	import com.funrun.controller.signals.AddPlaceableRequest;
	import com.funrun.controller.signals.AddPlayerRequest;
	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.controller.signals.AddView3DRequest;
	import com.funrun.controller.signals.CheckWhitelistRequest;
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.DisplayMessageRequest;
	import com.funrun.controller.signals.DisplayPlaceRequest;
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.EnablePlayerInputRequest;
	import com.funrun.controller.signals.HandleMultiplayerInitRequest;
	import com.funrun.controller.signals.HandleMultiplayerJoinGameRequest;
	import com.funrun.controller.signals.HandleMultiplayerNewPlayerJoinedRequest;
	import com.funrun.controller.signals.HandleMultiplayerPlayerDiedRequest;
	import com.funrun.controller.signals.HandleMultiplayerPlayerLeftRequest;
	import com.funrun.controller.signals.HandleMultiplayerUpdateRequest;
	import com.funrun.controller.signals.InitGameRequest;
	import com.funrun.controller.signals.InitModelsRequest;
	import com.funrun.controller.signals.JoinGameRequest;
	import com.funrun.controller.signals.JoinMatchmakingRequest;
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.LeaveGameRequest;
	import com.funrun.controller.signals.LoadBlocksRequest;
	import com.funrun.controller.signals.LoadConfigurationRequest;
	import com.funrun.controller.signals.LoadFloorsRequest;
	import com.funrun.controller.signals.LoadObstaclesRequest;
	import com.funrun.controller.signals.LoginFailed;
	import com.funrun.controller.signals.LoginFulfilled;
	import com.funrun.controller.signals.LoginRequest;
	import com.funrun.controller.signals.RemoveCompetitorRequest;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.RemoveNametagRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.RemovePlaceableRequest;
	import com.funrun.controller.signals.RemovePopupRequest;
	import com.funrun.controller.signals.RemoveResultsPopupRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.ResetCountdownRequest;
	import com.funrun.controller.signals.ResetGameRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.controller.signals.SendMultiplayerDeathRequest;
	import com.funrun.controller.signals.SendMultiplayerUpdateRequest;
	import com.funrun.controller.signals.ShowFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.controller.signals.ShowResultsPopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.StartCountdownRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.controller.signals.StartGameRequest;
	import com.funrun.controller.signals.StartObserverLoopRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.controller.signals.StopGameLoopRequest;
	import com.funrun.controller.signals.StopObserverLoopRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.UpdateCompetitorsRequest;
	import com.funrun.controller.signals.UpdateCountdownRequest;
	import com.funrun.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.controller.signals.UpdateObstaclesRequest;
	import com.funrun.controller.signals.UpdatePlacesRequest;
	import com.funrun.controller.signals.UpdatePlayerCollisionsRequest;
	import com.funrun.controller.signals.WhitelistFailed;
	import com.funrun.model.BlocksModel;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.ConfigurationModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.FloorsModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.GeosMockModel;
	import com.funrun.model.IGeosModel;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.LightsModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.model.PlacesModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.UserModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.state.OnlineState;
	import com.funrun.services.BlocksJsonService;
	import com.funrun.services.IWhitelistService;
	import com.funrun.services.MatchmakingService;
	import com.funrun.services.MultiplayerService;
	import com.funrun.services.ObstaclesJsonService;
	import com.funrun.services.OrdinalizeNumberService;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.WhitelistOpenService;
	import com.funrun.services.WhitelistService;
	import com.funrun.view.components.FindingGamePopup;
	import com.funrun.view.components.GameUIView;
	import com.funrun.view.components.GameView;
	import com.funrun.view.components.LoginStatusView;
	import com.funrun.view.components.MainMenuView;
	import com.funrun.view.components.MainView;
	import com.funrun.view.components.NametagsView;
	import com.funrun.view.components.PlayerioErrorPopupView;
	import com.funrun.view.components.PopupsView;
	import com.funrun.view.components.ResultsPopup;
	import com.funrun.view.components.TrackView;
	import com.funrun.view.mediators.AppMediator;
	import com.funrun.view.mediators.FindingGamePopupMediator;
	import com.funrun.view.mediators.GameMediator;
	import com.funrun.view.mediators.GameUIMediator;
	import com.funrun.view.mediators.LoginStatusMediator;
	import com.funrun.view.mediators.MainMediator;
	import com.funrun.view.mediators.MainMenuMediator;
	import com.funrun.view.mediators.NametagsMediator;
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
			// Switches.
			var useWhitelist:Boolean = true;
			var onlineState:OnlineState = new OnlineState( false );
		
			// Map switches.
			injector.mapValue( OnlineState, onlineState );
			
			// Map models.
			injector.mapSingletonOf( IGeosModel, GeosMockModel );
			injector.mapSingleton( BlocksModel );
			injector.mapSingleton( ObstaclesModel );
			injector.mapSingleton( MaterialsModel );
			injector.mapSingleton( LightsModel );
			injector.mapSingleton( TimeModel );
			injector.mapSingleton( TrackModel );
			injector.mapSingleton( PlayerModel );
			injector.mapSingleton( View3DModel );
			injector.mapSingleton( FloorsModel );
			injector.mapSingleton( GameModel );
			injector.mapSingleton( CountdownModel );
			injector.mapSingleton( ConfigurationModel );
			injector.mapSingleton( UserModel );
			injector.mapSingleton( CompetitorsModel );
			injector.mapSingleton( InterpolationModel );
			injector.mapSingleton( NametagsModel );
			injector.mapSingleton( PlacesModel );
			injector.mapSingleton( KeyboardModel );
			
			// Map services.
			injector.mapSingleton( BlocksJsonService );
			injector.mapSingleton( ObstaclesJsonService );
			injector.mapSingleton( PlayerioFacebookLoginService );
			injector.mapSingleton( MatchmakingService );
			injector.mapSingleton( MultiplayerService );
			injector.mapSingleton( OrdinalizeNumberService );
			if ( useWhitelist ) {
				// Block non-whitelisted users.
				injector.mapSingletonOf( IWhitelistService, WhitelistService );
			} else {
				// Allow everybody.
				injector.mapSingletonOf( IWhitelistService, WhitelistOpenService );
			}
			// Map signals.
			injector.mapSingleton( AddNametagRequest );
			injector.mapSingleton( AddPopupRequest );
			injector.mapSingleton( AddView3DRequest );
			injector.mapSingleton( DisplayDistanceRequest );
			injector.mapSingleton( DisplayMessageRequest );
			injector.mapSingleton( DisplayPlaceRequest );
			injector.mapSingleton( EnableMainMenuRequest );
			injector.mapSingleton( EnablePlayerInputRequest );
			injector.mapSingleton( RemoveFindingGamePopupRequest );
			injector.mapSingleton( RemovePopupRequest );
			injector.mapSingleton( RemoveResultsPopupRequest );
			injector.mapSingleton( RenderSceneRequest );
			injector.mapSingleton( RemoveNametagRequest );
			injector.mapSingleton( ShowScreenRequest );
			injector.mapSingleton( ToggleCountdownRequest );
			injector.mapSingleton( UpdateCountdownRequest );
			injector.mapSingleton( UpdateLoginStatusRequest );
			signalCommandMap.mapSignalClass( AddCompetitorRequest,					AddCompetitorCommand );
			signalCommandMap.mapSignalClass( AddEmptyFloorRequest,					AddEmptyFloorCommand );
			signalCommandMap.mapSignalClass( AddLightRequest,						AddLightCommand );
			signalCommandMap.mapSignalClass( AddMaterialRequest,					AddMaterialCommand );
			signalCommandMap.mapSignalClass( AddObjectToSceneRequest,				AddObjectToSceneCommand );
			signalCommandMap.mapSignalClass( AddObstacleRequest,					AddObstacleCommand );
			signalCommandMap.mapSignalClass( AddObstaclesRequest,					AddObstaclesCommand );
			signalCommandMap.mapSignalClass( AddPlaceableRequest,					AddPlaceableCommand );
			signalCommandMap.mapSignalClass( AddPlayerRequest,						AddPlayerCommand );
			signalCommandMap.mapSignalClass( InitGameRequest,						InitGameCommand );
			signalCommandMap.mapSignalClass( InitModelsRequest,						InitModelsCommand );
			signalCommandMap.mapSignalClass( CheckWhitelistRequest,					CheckWhitelistCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerInitRequest,			HandleMultiplayerInitCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerJoinGameRequest,		HandleMultiplayerJoinGameCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerNewPlayerJoinedRequest,HandleMultiplayerNewPlayerJoinedCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerPlayerDiedRequest,	HandleMultiplayerPlayerDiedCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerPlayerLeftRequest,	HandleMultiplayerPlayerLeftCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerUpdateRequest,		HandleMultiplayerUpdateCommand );
			signalCommandMap.mapSignalClass( JoinMatchmakingRequest,				JoinMatchmakingCommand );
			signalCommandMap.mapSignalClass( JoinGameRequest,						JoinGameCommand );
			signalCommandMap.mapSignalClass( KillPlayerRequest,						KillPlayerCommand );
			signalCommandMap.mapSignalClass( LeaveGameRequest,						LeaveGameCommand );
			signalCommandMap.mapSignalClass( LoadBlocksRequest,						LoadBlocksCommand );
			signalCommandMap.mapSignalClass( LoadConfigurationRequest, 				LoadConfigurationCommand );
			signalCommandMap.mapSignalClass( LoadFloorsRequest,						LoadFloorsCommand );
			signalCommandMap.mapSignalClass( LoadObstaclesRequest,					LoadObstaclesCommand );
			signalCommandMap.mapSignalClass( LoginRequest,							LoginCommand );
			signalCommandMap.mapSignalClass( LoginFailed,							LoginFailedCommand );
			signalCommandMap.mapSignalClass( LoginFulfilled,						LoginFulfilledCommand );
			signalCommandMap.mapSignalClass( RemoveCompetitorRequest,				RemoveCompetitorCommand );
			signalCommandMap.mapSignalClass( RemoveObjectFromSceneRequest,			RemoveObjectFromSceneCommand );
			signalCommandMap.mapSignalClass( RemovePlaceableRequest,				RemovePlaceableCommand );
			signalCommandMap.mapSignalClass( ResetCountdownRequest,					ResetCountdownCommand );
			signalCommandMap.mapSignalClass( ResetGameRequest,						ResetGameCommand );
			signalCommandMap.mapSignalClass( ResetPlayerRequest, 					ResetPlayerCommand );
			signalCommandMap.mapSignalClass( SendMultiplayerDeathRequest,			SendMultiplayerDeathCommand );
			signalCommandMap.mapSignalClass( SendMultiplayerUpdateRequest,			SendMultiplayerUpdateCommand );
			signalCommandMap.mapSignalClass( ShowFindingGamePopupRequest,			ShowFindingGamePopupCommand );
			signalCommandMap.mapSignalClass( ShowPlayerioErrorPopupRequest,			ShowPlayerioErrorPopupCommand );
			signalCommandMap.mapSignalClass( ShowResultsPopupRequest,				ShowResultsPopupCommand );
			signalCommandMap.mapSignalClass( StartCountdownRequest,					StartCountdownCommand );
			signalCommandMap.mapSignalClass( StartGameRequest,						StartGameCommand );
			signalCommandMap.mapSignalClass( StartGameLoopRequest,					StartGameLoopCommand );
			signalCommandMap.mapSignalClass( StartObserverLoopRequest,				StartObserverLoopCommand );
			signalCommandMap.mapSignalClass( StartRunningRequest,					StartRunningCommand );
			signalCommandMap.mapSignalClass( StopGameLoopRequest,					StopGameLoopCommand );
			signalCommandMap.mapSignalClass( StopObserverLoopRequest,				StopObserverLoopCommand );
			signalCommandMap.mapSignalClass( UpdateCompetitorsRequest,				UpdateCompetitorsCommand );
			signalCommandMap.mapSignalClass( UpdateObstaclesRequest,				UpdateObstaclesCommand );
			signalCommandMap.mapSignalClass( UpdatePlacesRequest,					UpdatePlacesCommand );
			signalCommandMap.mapSignalClass( UpdatePlayerCollisionsRequest,			UpdatePlayerCollisionsCommand );
			signalCommandMap.mapSignalClass( WhitelistFailed,						WhitelistFailedCommand );
			
			// Map events to commands.
			commandMap.mapEvent( KeyboardEvent.KEY_DOWN, KeyDownCommand, KeyboardEvent );
			commandMap.mapEvent( KeyboardEvent.KEY_UP, KeyUpCommand, KeyboardEvent );

			// Map views to mediators.
			mediatorMap.mapView( MainView, 					MainMediator );
			mediatorMap.mapView( TrackView, 				TrackMediator );
			mediatorMap.mapView( GameUIView,				GameUIMediator );
			mediatorMap.mapView( LoginStatusView, 			LoginStatusMediator );
			mediatorMap.mapView( GameView,					GameMediator );
			mediatorMap.mapView( MainMenuView,				MainMenuMediator );
			mediatorMap.mapView( PopupsView,				PopupsMediator );
			mediatorMap.mapView( ResultsPopup,				ResultPopupMediator );
			mediatorMap.mapView( FindingGamePopup,			FindingGamePopupMediator );
			mediatorMap.mapView( PlayerioErrorPopupView,	PlayerioErrorPopupMediator );
			mediatorMap.mapView( NametagsView,				NametagsMediator );
			
			// Do this last, since it causes our entire view system to be built.
			mediatorMap.mapView( FunRun, 					AppMediator );
			
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
