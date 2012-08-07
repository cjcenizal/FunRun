package com.funrun {
	
	import com.funrun.controller.commands.AddAiCompetitorsCommand;
	import com.funrun.controller.commands.AddCompetitorCommand;
	import com.funrun.controller.commands.AddDelayedCommandCommand;
	import com.funrun.controller.commands.AddFloorCommand;
	import com.funrun.controller.commands.AddLightCommand;
	import com.funrun.controller.commands.AddObjectToSceneCommand;
	import com.funrun.controller.commands.AddObstaclesCommand;
	import com.funrun.controller.commands.AddPlaceableCommand;
	import com.funrun.controller.commands.AddPlayerCommand;
	import com.funrun.controller.commands.AddSegmentCommand;
	import com.funrun.controller.commands.CompleteAppCommand;
	import com.funrun.controller.commands.CullSegmentsCommand;
	import com.funrun.controller.commands.EndRoundCommand;
	import com.funrun.controller.commands.FollowNewCompetitorCommand;
	import com.funrun.controller.commands.HandleMultiplayerCompetitorDiedCommand;
	import com.funrun.controller.commands.HandleMultiplayerCompetitorJoinedCommand;
	import com.funrun.controller.commands.HandleMultiplayerCompetitorLeftCommand;
	import com.funrun.controller.commands.HandleMultiplayerInitCommand;
	import com.funrun.controller.commands.HandleMultiplayerJoinGameCommand;
	import com.funrun.controller.commands.HandleMultiplayerUpdateCommand;
	import com.funrun.controller.commands.InitAppCommand;
	import com.funrun.controller.commands.JoinGameCommand;
	import com.funrun.controller.commands.JoinMatchmakingCommand;
	import com.funrun.controller.commands.KillPlayerCommand;
	import com.funrun.controller.commands.LeaveGameCommand;
	import com.funrun.controller.commands.LoadConfigurationCommand;
	import com.funrun.controller.commands.RemoveCompetitorCommand;
	import com.funrun.controller.commands.RemoveObjectFromSceneCommand;
	import com.funrun.controller.commands.RemovePlaceableCommand;
	import com.funrun.controller.commands.RenderSceneCommand;
	import com.funrun.controller.commands.ResetCountdownCommand;
	import com.funrun.controller.commands.ResetGameCommand;
	import com.funrun.controller.commands.ResetPlayerCommand;
	import com.funrun.controller.commands.SavePlayerObjectCommand;
	import com.funrun.controller.commands.SendMultiplayerDeathCommand;
	import com.funrun.controller.commands.SendMultiplayerUpdateCommand;
	import com.funrun.controller.commands.ShowFindingGamePopupCommand;
	import com.funrun.controller.commands.ShowPlayerioErrorPopupCommand;
	import com.funrun.controller.commands.StartCountdownCommand;
	import com.funrun.controller.commands.StartGameCommand;
	import com.funrun.controller.commands.StartGameLoopCommand;
	import com.funrun.controller.commands.StartObserverLoopCommand;
	import com.funrun.controller.commands.StartOfflineGameCommand;
	import com.funrun.controller.commands.StartRunningCommand;
	import com.funrun.controller.commands.StopGameLoopCommand;
	import com.funrun.controller.commands.StopObserverLoopCommand;
	import com.funrun.controller.commands.StoreFloorCommand;
	import com.funrun.controller.commands.StoreObstacleCommand;
	import com.funrun.controller.commands.UpdateAiCompetitorsCommand;
	import com.funrun.controller.commands.UpdateCompetitorsCommand;
	import com.funrun.controller.commands.UpdateNametagsCommand;
	import com.funrun.controller.commands.UpdatePlacesCommand;
	import com.funrun.controller.commands.UpdatePlayerCollisionsCommand;
	import com.funrun.controller.commands.UpdateTrackCommand;
	import com.funrun.controller.signals.AddAiCompetitorsRequest;
	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.AddDelayedCommandRequest;
	import com.funrun.controller.signals.AddFloorRequest;
	import com.funrun.controller.signals.AddLightRequest;
	import com.funrun.controller.signals.AddNametagRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddObstaclesRequest;
	import com.funrun.controller.signals.AddPlaceableRequest;
	import com.funrun.controller.signals.AddPlayerRequest;
	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.controller.signals.AddSegmentRequest;
	import com.funrun.controller.signals.AddView3DRequest;
	import com.funrun.controller.signals.CompleteAppRequest;
	import com.funrun.controller.signals.CullSegmentsRequest;
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.DisplayMessageRequest;
	import com.funrun.controller.signals.DisplayPlaceRequest;
	import com.funrun.controller.signals.EnableMainMenuRequest;
	import com.funrun.controller.signals.EndRoundRequest;
	import com.funrun.controller.signals.FollowNewCompetitorRequest;
	import com.funrun.controller.signals.HandleMultiplayerCompetitorDiedRequest;
	import com.funrun.controller.signals.HandleMultiplayerCompetitorJoinedRequest;
	import com.funrun.controller.signals.HandleMultiplayerCompetitorLeftRequest;
	import com.funrun.controller.signals.HandleMultiplayerInitRequest;
	import com.funrun.controller.signals.HandleMultiplayerJoinGameRequest;
	import com.funrun.controller.signals.HandleMultiplayerUpdateRequest;
	import com.funrun.controller.signals.JoinGameRequest;
	import com.funrun.controller.signals.JoinMatchmakingRequest;
	import com.funrun.controller.signals.KillPlayerRequest;
	import com.funrun.controller.signals.LeaveGameRequest;
	import com.funrun.controller.signals.LoadConfigurationRequest;
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
	import com.funrun.controller.signals.SavePlayerObjectRequest;
	import com.funrun.controller.signals.SendMultiplayerDeathRequest;
	import com.funrun.controller.signals.SendMultiplayerUpdateRequest;
	import com.funrun.controller.signals.ShowFindingGamePopupRequest;
	import com.funrun.controller.signals.ShowPlayerioErrorPopupRequest;
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.controller.signals.ShowStatsRequest;
	import com.funrun.controller.signals.StartCountdownRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.controller.signals.StartGameRequest;
	import com.funrun.controller.signals.StartObserverLoopRequest;
	import com.funrun.controller.signals.StartOfflineGameRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.controller.signals.StopGameLoopRequest;
	import com.funrun.controller.signals.StopObserverLoopRequest;
	import com.funrun.controller.signals.StoreFloorRequest;
	import com.funrun.controller.signals.StoreObstacleRequest;
	import com.funrun.controller.signals.ToggleCountdownRequest;
	import com.funrun.controller.signals.UpdateAiCompetitorsRequest;
	import com.funrun.controller.signals.UpdateCompetitorsRequest;
	import com.funrun.controller.signals.UpdateCountdownRequest;
	import com.funrun.controller.signals.UpdateLoginStatusRequest;
	import com.funrun.controller.signals.UpdateNametagsRequest;
	import com.funrun.controller.signals.UpdatePlacesRequest;
	import com.funrun.controller.signals.UpdatePlayerCollisionsRequest;
	import com.funrun.controller.signals.UpdateTrackRequest;
	import com.funrun.model.BlocksModel;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.ConfigurationModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.DelayedCommandsModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.LightsModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.ObserverModel;
	import com.funrun.model.PlacesModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.state.OnlineState;
	import com.funrun.model.state.ProductionState;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.services.IWhitelistService;
	import com.funrun.services.MatchmakingService;
	import com.funrun.services.MultiplayerService;
	import com.funrun.services.OrdinalizeNumberService;
	import com.funrun.services.PlayerioFacebookLoginService;
	import com.funrun.services.PlayerioMultiplayerService;
	import com.funrun.services.PlayerioPlayerObjectService;
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
	
	import org.robotlegs.mvcs.SignalContext;
	
	public class MainContext extends SignalContext {
		
		public function MainContext( contextView:DisplayObjectContainer, autoStartup:Boolean ) {
			super( contextView, autoStartup );
		}
		
		override public function startup():void {
			// Switches.
			var useWhitelist:Boolean 				= true;
			var onlineState:OnlineState 			= new OnlineState( false );
			var productionState:ProductionState 	= new ProductionState( false );
			var showBoundsState:ShowBoundsState		= new ShowBoundsState( true );
			
			// Map switches.
			injector.mapValue( OnlineState, onlineState );
			injector.mapValue( ProductionState, productionState );
			injector.mapValue( ShowBoundsState, showBoundsState );
			
			// Apply whitelist switch.
			if ( useWhitelist ) {
				// Block non-whitelisted users.
				injector.mapSingletonOf( IWhitelistService, WhitelistService );
			} else {
				// Allow everybody.
				injector.mapSingletonOf( IWhitelistService, WhitelistOpenService );
			}
			
			// Map models.
			injector.mapSingleton( BlocksModel );
			injector.mapSingleton( CompetitorsModel );
			injector.mapSingleton( ConfigurationModel );
			injector.mapSingleton( CountdownModel );
			injector.mapSingleton( DelayedCommandsModel );
			injector.mapSingleton( GameModel );
			injector.mapSingleton( InterpolationModel );
			injector.mapSingleton( KeyboardModel );
			injector.mapSingleton( LightsModel );
			injector.mapSingleton( MaterialsModel );
			injector.mapSingleton( NametagsModel );
			injector.mapSingleton( ObserverModel );
			injector.mapSingleton( PlacesModel );
			injector.mapSingleton( PlayerModel );
			injector.mapSingleton( PointsModel );
			injector.mapSingleton( SegmentsModel );
			injector.mapSingleton( TimeModel );
			injector.mapSingleton( TrackModel );
			injector.mapSingleton( View3DModel );
			
			// Map services.
			injector.mapSingleton( MatchmakingService );
			injector.mapSingleton( MultiplayerService );
			injector.mapSingleton( OrdinalizeNumberService );
			injector.mapSingleton( PlayerioFacebookLoginService );
			injector.mapSingleton( PlayerioMultiplayerService );
			injector.mapSingleton( PlayerioPlayerObjectService );
			
			// Map signals.
			injector.mapSingleton( AddNametagRequest );
			injector.mapSingleton( AddPopupRequest );
			injector.mapSingleton( AddView3DRequest );
			injector.mapSingleton( DisplayDistanceRequest );
			injector.mapSingleton( DisplayMessageRequest );
			injector.mapSingleton( DisplayPlaceRequest );
			injector.mapSingleton( EnableMainMenuRequest );
			injector.mapSingleton( RemoveFindingGamePopupRequest );
			injector.mapSingleton( RemovePopupRequest );
			injector.mapSingleton( RemoveResultsPopupRequest );
			injector.mapSingleton( RemoveNametagRequest );
			injector.mapSingleton( ShowScreenRequest );
			injector.mapSingleton( ShowStatsRequest );
			injector.mapSingleton( ToggleCountdownRequest );
			injector.mapSingleton( UpdateCountdownRequest );
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
			signalCommandMap.mapSignalClass( AddPlayerRequest,						AddPlayerCommand );
			signalCommandMap.mapSignalClass( CompleteAppRequest,					CompleteAppCommand );
			signalCommandMap.mapSignalClass( CullSegmentsRequest,					CullSegmentsCommand );
			signalCommandMap.mapSignalClass( EndRoundRequest,						EndRoundCommand );
			signalCommandMap.mapSignalClass( FollowNewCompetitorRequest,			FollowNewCompetitorCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerInitRequest,			HandleMultiplayerInitCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerJoinGameRequest,		HandleMultiplayerJoinGameCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerCompetitorJoinedRequest,HandleMultiplayerCompetitorJoinedCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerCompetitorDiedRequest,HandleMultiplayerCompetitorDiedCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerCompetitorLeftRequest,HandleMultiplayerCompetitorLeftCommand );
			signalCommandMap.mapSignalClass( HandleMultiplayerUpdateRequest,		HandleMultiplayerUpdateCommand );
			signalCommandMap.mapSignalClass( JoinMatchmakingRequest,				JoinMatchmakingCommand );
			signalCommandMap.mapSignalClass( JoinGameRequest,						JoinGameCommand );
			signalCommandMap.mapSignalClass( KillPlayerRequest,						KillPlayerCommand );
			signalCommandMap.mapSignalClass( LeaveGameRequest,						LeaveGameCommand );
			signalCommandMap.mapSignalClass( LoadConfigurationRequest, 				LoadConfigurationCommand );
			signalCommandMap.mapSignalClass( RemoveCompetitorRequest,				RemoveCompetitorCommand );
			signalCommandMap.mapSignalClass( RemoveObjectFromSceneRequest,			RemoveObjectFromSceneCommand );
			signalCommandMap.mapSignalClass( RemovePlaceableRequest,				RemovePlaceableCommand );
			signalCommandMap.mapSignalClass( RenderSceneRequest,					RenderSceneCommand );
			signalCommandMap.mapSignalClass( ResetCountdownRequest,					ResetCountdownCommand );
			signalCommandMap.mapSignalClass( ResetGameRequest,						ResetGameCommand );
			signalCommandMap.mapSignalClass( ResetPlayerRequest, 					ResetPlayerCommand );
			signalCommandMap.mapSignalClass( SavePlayerObjectRequest,				SavePlayerObjectCommand );
			signalCommandMap.mapSignalClass( SendMultiplayerDeathRequest,			SendMultiplayerDeathCommand );
			signalCommandMap.mapSignalClass( SendMultiplayerUpdateRequest,			SendMultiplayerUpdateCommand );
			signalCommandMap.mapSignalClass( ShowFindingGamePopupRequest,			ShowFindingGamePopupCommand );
			signalCommandMap.mapSignalClass( ShowPlayerioErrorPopupRequest,			ShowPlayerioErrorPopupCommand );
			signalCommandMap.mapSignalClass( StartCountdownRequest,					StartCountdownCommand );
			signalCommandMap.mapSignalClass( StartGameRequest,						StartGameCommand );
			signalCommandMap.mapSignalClass( StartGameLoopRequest,					StartGameLoopCommand );
			signalCommandMap.mapSignalClass( StartObserverLoopRequest,				StartObserverLoopCommand );
			signalCommandMap.mapSignalClass( StartOfflineGameRequest,				StartOfflineGameCommand );
			signalCommandMap.mapSignalClass( StartRunningRequest,					StartRunningCommand );
			signalCommandMap.mapSignalClass( StopGameLoopRequest,					StopGameLoopCommand );
			signalCommandMap.mapSignalClass( StopObserverLoopRequest,				StopObserverLoopCommand );
			signalCommandMap.mapSignalClass( StoreFloorRequest,						StoreFloorCommand );
			signalCommandMap.mapSignalClass( StoreObstacleRequest,					StoreObstacleCommand );
			signalCommandMap.mapSignalClass( UpdateAiCompetitorsRequest,			UpdateAiCompetitorsCommand );
			signalCommandMap.mapSignalClass( UpdateCompetitorsRequest,				UpdateCompetitorsCommand );
			signalCommandMap.mapSignalClass( UpdateNametagsRequest,					UpdateNametagsCommand );
			signalCommandMap.mapSignalClass( UpdateTrackRequest,					UpdateTrackCommand );
			signalCommandMap.mapSignalClass( UpdatePlacesRequest,					UpdatePlacesCommand );
			signalCommandMap.mapSignalClass( UpdatePlayerCollisionsRequest,			UpdatePlayerCollisionsCommand );
			
			// Map views to mediators.
			mediatorMap.mapView( FindingGamePopup,			FindingGamePopupMediator );
			mediatorMap.mapView( GameUIView,				GameUIMediator );
			mediatorMap.mapView( GameView,					GameMediator );
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
