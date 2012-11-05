package com.funrun {

	import com.cenizal.utils.Console;
	import com.funrun.controller.commands.AddAiCompetitorsCommand;
	import com.funrun.controller.commands.AddCompetitorCommand;
	import com.funrun.controller.commands.AddDelayedCommandCommand;
	import com.funrun.controller.commands.AddFloorCommand;
	import com.funrun.controller.commands.AddLightCommand;
	import com.funrun.controller.commands.AddObjectToSceneCommand;
	import com.funrun.controller.commands.AddObstaclesCommand;
	import com.funrun.controller.commands.AddPlaceableCommand;
	import com.funrun.controller.commands.AddSegmentCommand;
	import com.funrun.controller.commands.CollectPointCommand;
	import com.funrun.controller.commands.CompleteAppCommand;
	import com.funrun.controller.commands.CullTrackCommand;
	import com.funrun.controller.commands.DrawReadyListCommand;
	import com.funrun.controller.commands.EndRoundCommand;
	import com.funrun.controller.commands.FollowNewCompetitorCommand;
	import com.funrun.controller.commands.HandleGameCompetitorDiedCommand;
	import com.funrun.controller.commands.HandleGameCompetitorJoinedCommand;
	import com.funrun.controller.commands.HandleGameCompetitorLeftCommand;
	import com.funrun.controller.commands.HandleGameInitCommand;
	import com.funrun.controller.commands.HandleGameUpdateCommand;
	import com.funrun.controller.commands.HandleLobbyChatCommand;
	import com.funrun.controller.commands.HandleLobbyPlayerJoinedCommand;
	import com.funrun.controller.commands.HandleLobbyPlayerLeftCommand;
	import com.funrun.controller.commands.HandleLobbyWelcomeCommand;
	import com.funrun.controller.commands.InitAppCommand;
	import com.funrun.controller.commands.JoinGameCommand;
	import com.funrun.controller.commands.JoinLobbyCommand;
	import com.funrun.controller.commands.JoinMainMenuCommand;
	import com.funrun.controller.commands.JoinMatchmakingCommand;
	import com.funrun.controller.commands.JoinSinglePlayerGameCommand;
	import com.funrun.controller.commands.KillPlayerCommand;
	import com.funrun.controller.commands.LeaveGameCommand;
	import com.funrun.controller.commands.LeaveLobbyAndEnterGameCommand;
	import com.funrun.controller.commands.LeaveLobbyAndEnterMainMenuCommand;
	import com.funrun.controller.commands.LoadConfigurationCommand;
	import com.funrun.controller.commands.LogMessageCommand;
	import com.funrun.controller.commands.PlaySoundCommand;
	import com.funrun.controller.commands.RemoveCompetitorCommand;
	import com.funrun.controller.commands.RemoveObjectFromSceneCommand;
	import com.funrun.controller.commands.RemovePlaceableCommand;
	import com.funrun.controller.commands.RenderSceneCommand;
	import com.funrun.controller.commands.ResetGameCommand;
	import com.funrun.controller.commands.ResetPlayerCommand;
	import com.funrun.controller.commands.SavePlayerObjectCommand;
	import com.funrun.controller.commands.SendGameDeathCommand;
	import com.funrun.controller.commands.SendGameUpdateCommand;
	import com.funrun.controller.commands.SendLobbyChatCommand;
	import com.funrun.controller.commands.SendMatchmakingReadyCommand;
	import com.funrun.controller.commands.ShakeCameraCommand;
	import com.funrun.controller.commands.ShowFindingGamePopupCommand;
	import com.funrun.controller.commands.ShowJoiningLobbyPopupCommand;
	import com.funrun.controller.commands.ShowPlayerioErrorPopupCommand;
	import com.funrun.controller.commands.ShowStoreCommand;
	import com.funrun.controller.commands.StartCountdownCommand;
	import com.funrun.controller.commands.StartGameLoopCommand;
	import com.funrun.controller.commands.StartObserverLoopCommand;
	import com.funrun.controller.commands.StartOfflineGameCommand;
	import com.funrun.controller.commands.StartRunningCommand;
	import com.funrun.controller.commands.StopGameLoopCommand;
	import com.funrun.controller.commands.StopObserverLoopCommand;
	import com.funrun.controller.commands.StoreFloorCommand;
	import com.funrun.controller.commands.StoreObstacleCommand;
	import com.funrun.controller.commands.UpdateAiCompetitorsCommand;
	import com.funrun.controller.commands.UpdateCollisionsCommand;
	import com.funrun.controller.commands.UpdateCompetitorsCommand;
	import com.funrun.controller.commands.UpdatePlayerCommand;
	import com.funrun.controller.commands.UpdateTrackCommand;
	import com.funrun.controller.commands.UpdateUiCommand;
	import com.funrun.controller.commands.UpdateViewCommand;
	import com.funrun.controller.signals.AddAiCompetitorsRequest;
	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.AddDelayedCommandRequest;
	import com.funrun.controller.signals.AddFloorRequest;
	import com.funrun.controller.signals.AddLightRequest;
	import com.funrun.controller.signals.AddNametagRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddObstaclesRequest;
	import com.funrun.controller.signals.AddPlaceableRequest;
	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.controller.signals.AddSegmentRequest;
	import com.funrun.controller.signals.AddToReadyListRequest;
	import com.funrun.controller.signals.AddView3DRequest;
	import com.funrun.controller.signals.ClearReadyListRequest;
	import com.funrun.controller.signals.CollectPointRequest;
	import com.funrun.controller.signals.CompleteAppRequest;
	import com.funrun.controller.signals.CullTrackRequest;
	import com.funrun.controller.signals.DrawCountdownRequest;
	import com.funrun.controller.signals.DrawGameMessageRequest;
	import com.funrun.controller.signals.DrawLobbyChatRequest;
	import com.funrun.controller.signals.DrawLobbyPlayerJoinedRequest;
	import com.funrun.controller.signals.DrawLobbyPlayerLeftRequest;
	import com.funrun.controller.signals.DrawPointsRequest;
	import com.funrun.controller.signals.DrawReadyListRequest;
	import com.funrun.controller.signals.DrawSpeedRequest;
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.EndRoundRequest;
	import com.funrun.controller.signals.FollowNewCompetitorRequest;
	import com.funrun.controller.signals.HandleGameCompetitorDiedRequest;
	import com.funrun.controller.signals.HandleGameCompetitorJoinedRequest;
	import com.funrun.controller.signals.HandleGameCompetitorLeftRequest;
	import com.funrun.controller.signals.HandleGameInitRequest;
	import com.funrun.controller.signals.HandleGameUpdateRequest;
	import com.funrun.controller.signals.HandleLobbyChatRequest;
	import com.funrun.controller.signals.HandleLobbyPlayerJoinedRequest;
	import com.funrun.controller.signals.HandleLobbyPlayerLeftRequest;
	import com.funrun.controller.signals.HandleLobbyWelcomeRequest;
	import com.funrun.controller.signals.JoinGameRequest;
	import com.funrun.controller.signals.JoinLobbyRequest;
	import com.funrun.controller.signals.JoinMainMenuRequest;
	import com.funrun.controller.signals.JoinMatchmakingRequest;
	import com.funrun.controller.signals.JoinSinglePlayerGameRequest;
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.LeaveGameAndEnterLobbyRequest;
	import com.funrun.controller.signals.LeaveLobbyAndEnterGameRequest;
	import com.funrun.controller.signals.LeaveLobbyAndEnterMainMenuRequest;
	import com.funrun.controller.signals.LoadConfigurationRequest;
	import com.funrun.controller.signals.LogMessageRequest;
	import com.funrun.controller.signals.PlaySoundRequest;
	import com.funrun.controller.signals.RemoveCompetitorRequest;
	import com.funrun.controller.signals.RemoveFindingGamePopupRequest;
	import com.funrun.controller.signals.RemoveJoiningLobbyPopupRequest;
	import com.funrun.controller.signals.RemoveNametagRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.RemovePlaceableRequest;
	import com.funrun.controller.signals.RemovePopupRequest;
	import com.funrun.controller.signals.RemoveResultsPopupRequest;
	import com.funrun.controller.signals.RenderSceneRequest;
	import com.funrun.controller.signals.ResetGameRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.controller.signals.SavePlayerObjectRequest;
	import com.funrun.controller.signals.SendGameDeathRequest;
	import com.funrun.controller.signals.SendGameUpdateRequest;
	import com.funrun.controller.signals.SendLobbyChatRequest;
	import com.funrun.controller.signals.SendMatchmakingReadyRequest;
	import com.funrun.controller.signals.ShakeCameraRequest;
	import com.funrun.controller.signals.ShowFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowJoiningLobbyPopupRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.ShowStatsRequest;
	import com.funrun.controller.signals.ShowStoreRequest;
	import com.funrun.controller.signals.StartCountdownRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.controller.signals.StartObserverLoopRequest;
	import com.funrun.controller.signals.StartOfflineGameRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.controller.signals.StopGameLoopRequest;
	import com.funrun.controller.signals.StopObserverLoopRequest;
	import com.funrun.controller.signals.StoreFloorRequest;
	import com.funrun.controller.signals.StoreObstacleRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.ToggleReadyButtonRequest;
	import com.funrun.controller.signals.ToggleReadyListRequest;
	import com.funrun.controller.signals.UpdateAiCompetitorsRequest;
	import com.funrun.controller.signals.UpdateCollisionsRequest;
	import com.funrun.controller.signals.UpdateCompetitorsRequest;
	import com.funrun.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.controller.signals.UpdatePlayerRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.controller.signals.UpdateUiRequest;
	import com.funrun.controller.signals.UpdateViewRequest;
	import com.funrun.model.AccountModel;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.BlockTypesModel;
	import com.funrun.model.ColorsModel;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.ConfigurationModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.DelayedCommandsModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.LightsModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.MouseModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.ObserverModel;
	import com.funrun.model.PlacesModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.RewardsModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.SoundsModel;
	import com.funrun.model.StateModel;
	import com.funrun.model.StoreModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.View3dModel;
	import com.funrun.services.GameService;
	import com.funrun.services.IWhitelistService;
	import com.funrun.services.LobbyService;
	import com.funrun.services.MatchmakingService;
	import com.funrun.services.OrdinalizeNumberService;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.PlayerioMultiplayerService;
	import com.funrun.services.PlayerioPlayerObjectService;
	import com.funrun.services.WhitelistOpenService;
	import com.funrun.services.WhitelistService;
	import com.funrun.view.components.FindingGamePopup;
	import com.funrun.view.components.GameUIView;
	import com.funrun.view.components.GameView;
	import com.funrun.view.components.JoiningLobbyPopup;
	import com.funrun.view.components.LobbyView;
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
	import com.funrun.view.mediators.JoiningLobbyPopupMediator;
	import com.funrun.view.mediators.LobbyMediator;
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
	
	import org.robotlegs.mvcs.SignalContext;
	
	public class MainContext extends SignalContext {
		
		public function MainContext( contextView:DisplayObjectContainer, autoStartup:Boolean ) {
			super( contextView, autoStartup );
		}
		
		override public function startup():void {
			// Switches.
			var useWhitelist:Boolean 				= false;
			var isProduction:Boolean				= false;
			var isOnline:Boolean					= false;
			var showBounds:Boolean					= false;
			var gameModel:GameModel = new GameModel( isProduction, isOnline, showBounds );
			gameModel.showStats 					= false;
			gameModel.usePoints						= true;
			
			// Map switches.
			injector.mapValue( GameModel, gameModel );
			
			// Apply whitelist switch.
			if ( gameModel.isOnline && useWhitelist ) {
				// Block non-whitelisted users.
				injector.mapSingletonOf( IWhitelistService, WhitelistService );
			} else {
				// Allow everybody.
				injector.mapSingletonOf( IWhitelistService, WhitelistOpenService );
			}
			
			// Map models.
			injector.mapSingleton( AccountModel );
			injector.mapSingleton( BlockStylesModel );
			injector.mapSingleton( BlockTypesModel );
			injector.mapSingleton( CompetitorsModel );
			injector.mapSingleton( ColorsModel );
			injector.mapSingleton( ConfigurationModel );
			injector.mapSingleton( CountdownModel );
			injector.mapSingleton( DelayedCommandsModel );
			injector.mapSingleton( InterpolationModel );
			injector.mapSingleton( KeyboardModel );
			injector.mapSingleton( LightsModel );
			injector.mapSingleton( MaterialsModel );
			injector.mapSingleton( MouseModel );
			injector.mapSingleton( NametagsModel );
			injector.mapSingleton( ObserverModel );
			injector.mapSingleton( PlacesModel );
			injector.mapSingleton( PlayerModel );
			injector.mapSingleton( PointsModel );
			injector.mapSingleton( RewardsModel );
			injector.mapSingleton( SegmentsModel );
			injector.mapSingleton( SoundsModel );
			injector.mapSingleton( StateModel );
			injector.mapSingleton( StoreModel );
			injector.mapSingleton( TimeModel );
			injector.mapSingleton( TrackModel );
			injector.mapSingleton( View3dModel );
			
			// Map services.
			injector.mapSingleton( GameService );
			injector.mapSingleton( LobbyService );
			injector.mapSingleton( MatchmakingService );
			injector.mapSingleton( OrdinalizeNumberService );
			injector.mapSingleton( PlayerioFacebookLoginService );
			injector.mapSingleton( PlayerioMultiplayerService );
			injector.mapSingleton( PlayerioPlayerObjectService );
			
			// Map signals.
			injector.mapSingleton( AddNametagRequest );
			injector.mapSingleton( AddPopupRequest );
			injector.mapSingleton( AddToReadyListRequest );
			injector.mapSingleton( AddView3DRequest );
			injector.mapSingleton( ClearReadyListRequest );
			injector.mapSingleton( DrawCountdownRequest );
			injector.mapSingleton( DrawGameMessageRequest );
			injector.mapSingleton( DrawLobbyChatRequest );
			injector.mapSingleton( DrawLobbyPlayerJoinedRequest );
			injector.mapSingleton( DrawLobbyPlayerLeftRequest );
			injector.mapSingleton( DrawPointsRequest );
			injector.mapSingleton( DrawSpeedRequest );
			injector.mapSingleton( EnableMainMenuRequest );
			injector.mapSingleton( RemoveFindingGamePopupRequest );
			injector.mapSingleton( RemoveJoiningLobbyPopupRequest );
			injector.mapSingleton( RemovePopupRequest );
			injector.mapSingleton( RemoveResultsPopupRequest );
			injector.mapSingleton( RemoveNametagRequest );
			injector.mapSingleton( ShowScreenRequest );
			injector.mapSingleton( ShowStatsRequest );
			injector.mapSingleton( ToggleCountdownRequest );
			injector.mapSingleton( ToggleReadyButtonRequest );
			injector.mapSingleton( ToggleReadyListRequest );
			injector.mapSingleton( UpdateLoginStatusRequest );
			signalCommandMap.mapSignalClass( AddAiCompetitorsRequest,				AddAiCompetitorsCommand );
			signalCommandMap.mapSignalClass( AddCompetitorRequest,					AddCompetitorCommand );
			signalCommandMap.mapSignalClass( AddDelayedCommandRequest,				AddDelayedCommandCommand );
			signalCommandMap.mapSignalClass( AddFloorRequest,						AddFloorCommand );
			signalCommandMap.mapSignalClass( AddLightRequest,						AddLightCommand );
			signalCommandMap.mapSignalClass( AddObjectToSceneRequest,				AddObjectToSceneCommand );
			signalCommandMap.mapSignalClass( AddSegmentRequest,						AddSegmentCommand );
			signalCommandMap.mapSignalClass( AddObstaclesRequest,					AddObstaclesCommand );
			signalCommandMap.mapSignalClass( AddPlaceableRequest,					AddPlaceableCommand );
			signalCommandMap.mapSignalClass( JoinLobbyRequest,						JoinLobbyCommand );
			signalCommandMap.mapSignalClass( CollectPointRequest,					CollectPointCommand );
			signalCommandMap.mapSignalClass( CompleteAppRequest,					CompleteAppCommand );
			signalCommandMap.mapSignalClass( CullTrackRequest,						CullTrackCommand );
			signalCommandMap.mapSignalClass( DrawReadyListRequest,					DrawReadyListCommand );
			signalCommandMap.mapSignalClass( EndRoundRequest,						EndRoundCommand );
			signalCommandMap.mapSignalClass( FollowNewCompetitorRequest,			FollowNewCompetitorCommand );
			signalCommandMap.mapSignalClass( HandleGameInitRequest,					HandleGameInitCommand );
			signalCommandMap.mapSignalClass( HandleGameCompetitorJoinedRequest,		HandleGameCompetitorJoinedCommand );
			signalCommandMap.mapSignalClass( HandleGameCompetitorDiedRequest,		HandleGameCompetitorDiedCommand );
			signalCommandMap.mapSignalClass( HandleGameCompetitorLeftRequest,		HandleGameCompetitorLeftCommand );
			signalCommandMap.mapSignalClass( HandleGameUpdateRequest,				HandleGameUpdateCommand );
			signalCommandMap.mapSignalClass( HandleLobbyChatRequest,				HandleLobbyChatCommand );
			signalCommandMap.mapSignalClass( HandleLobbyPlayerJoinedRequest,		HandleLobbyPlayerJoinedCommand );
			signalCommandMap.mapSignalClass( HandleLobbyPlayerLeftRequest,			HandleLobbyPlayerLeftCommand );
			signalCommandMap.mapSignalClass( HandleLobbyWelcomeRequest,				HandleLobbyWelcomeCommand );
			signalCommandMap.mapSignalClass( JoinGameRequest,						JoinGameCommand );
			signalCommandMap.mapSignalClass( JoinMainMenuRequest,					JoinMainMenuCommand );
			signalCommandMap.mapSignalClass( JoinMatchmakingRequest,				JoinMatchmakingCommand );
			signalCommandMap.mapSignalClass( JoinSinglePlayerGameRequest,			JoinSinglePlayerGameCommand );
			signalCommandMap.mapSignalClass( KillPlayerRequest,						KillPlayerCommand );
			signalCommandMap.mapSignalClass( LeaveGameAndEnterLobbyRequest,			LeaveGameCommand );
			signalCommandMap.mapSignalClass( LeaveLobbyAndEnterGameRequest,			LeaveLobbyAndEnterGameCommand );
			signalCommandMap.mapSignalClass( LeaveLobbyAndEnterMainMenuRequest,		LeaveLobbyAndEnterMainMenuCommand );
			signalCommandMap.mapSignalClass( LoadConfigurationRequest, 				LoadConfigurationCommand );
			signalCommandMap.mapSignalClass( LogMessageRequest, 					LogMessageCommand );
			signalCommandMap.mapSignalClass( PlaySoundRequest,						PlaySoundCommand );
			signalCommandMap.mapSignalClass( RemoveCompetitorRequest,				RemoveCompetitorCommand );
			signalCommandMap.mapSignalClass( RemoveObjectFromSceneRequest,			RemoveObjectFromSceneCommand );
			signalCommandMap.mapSignalClass( RemovePlaceableRequest,				RemovePlaceableCommand );
			signalCommandMap.mapSignalClass( RenderSceneRequest,					RenderSceneCommand );
			signalCommandMap.mapSignalClass( ResetGameRequest,						ResetGameCommand );
			signalCommandMap.mapSignalClass( ResetPlayerRequest, 					ResetPlayerCommand );
			signalCommandMap.mapSignalClass( SavePlayerObjectRequest,				SavePlayerObjectCommand );
			signalCommandMap.mapSignalClass( SendLobbyChatRequest,					SendLobbyChatCommand );
			signalCommandMap.mapSignalClass( SendMatchmakingReadyRequest,			SendMatchmakingReadyCommand );
			signalCommandMap.mapSignalClass( SendGameDeathRequest,					SendGameDeathCommand );
			signalCommandMap.mapSignalClass( SendGameUpdateRequest,					SendGameUpdateCommand );
			signalCommandMap.mapSignalClass( ShakeCameraRequest,					ShakeCameraCommand );
			signalCommandMap.mapSignalClass( ShowFindingGamePopupRequest,			ShowFindingGamePopupCommand );
			signalCommandMap.mapSignalClass( ShowJoiningLobbyPopupRequest,			ShowJoiningLobbyPopupCommand );
			signalCommandMap.mapSignalClass( ShowPlayerioErrorPopupRequest,			ShowPlayerioErrorPopupCommand );
			signalCommandMap.mapSignalClass( ShowStoreRequest,						ShowStoreCommand );
			signalCommandMap.mapSignalClass( StartCountdownRequest,					StartCountdownCommand );
			signalCommandMap.mapSignalClass( StartGameLoopRequest,					StartGameLoopCommand );
			signalCommandMap.mapSignalClass( StartObserverLoopRequest,				StartObserverLoopCommand );
			signalCommandMap.mapSignalClass( StartOfflineGameRequest,				StartOfflineGameCommand );
			signalCommandMap.mapSignalClass( StartRunningRequest,					StartRunningCommand );
			signalCommandMap.mapSignalClass( StopGameLoopRequest,					StopGameLoopCommand );
			signalCommandMap.mapSignalClass( StopObserverLoopRequest,				StopObserverLoopCommand );
			signalCommandMap.mapSignalClass( StoreFloorRequest,						StoreFloorCommand );
			signalCommandMap.mapSignalClass( StoreObstacleRequest,					StoreObstacleCommand );
			signalCommandMap.mapSignalClass( UpdateAiCompetitorsRequest,			UpdateAiCompetitorsCommand );
			signalCommandMap.mapSignalClass( UpdateCollisionsRequest,				UpdateCollisionsCommand );
			signalCommandMap.mapSignalClass( UpdateCompetitorsRequest,				UpdateCompetitorsCommand );
			signalCommandMap.mapSignalClass( UpdatePlayerRequest,					UpdatePlayerCommand );
			signalCommandMap.mapSignalClass( UpdateTrackRequest,					UpdateTrackCommand );
			signalCommandMap.mapSignalClass( UpdateUiRequest,						UpdateUiCommand );
			signalCommandMap.mapSignalClass( UpdateViewRequest,						UpdateViewCommand );
			
			// Map singleton views.
			injector.mapSingleton( Console );
			
			// Map views to mediators.
			mediatorMap.mapView( FindingGamePopup,			FindingGamePopupMediator );
			mediatorMap.mapView( GameUIView,				GameUIMediator );
			mediatorMap.mapView( GameView,					GameMediator );
			mediatorMap.mapView( JoiningLobbyPopup,			JoiningLobbyPopupMediator );
			mediatorMap.mapView( LobbyView, 				LobbyMediator );
			mediatorMap.mapView( LoginStatusView, 			LoginStatusMediator );
			mediatorMap.mapView( MainView, 					MainMediator );
			mediatorMap.mapView( MainMenuView,				MainMenuMediator );
			mediatorMap.mapView( NametagsView,				NametagsMediator );
			mediatorMap.mapView( PlayerioErrorPopupView,	PlayerioErrorPopupMediator );
			mediatorMap.mapView( PopupsView,				PopupsMediator );
			mediatorMap.mapView( ResultsPopup,				ResultPopupMediator );
			mediatorMap.mapView( TrackView, 				TrackMediator );
			
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
