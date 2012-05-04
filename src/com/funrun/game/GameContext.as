package com.funrun.game
{
	
	import com.funrun.game.controller.commands.AddObstacleCommand;
	import com.funrun.game.controller.commands.StartGameCommand;
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.AddObstacleRequest;
	import com.funrun.game.controller.events.StartGameRequest;
	import com.funrun.game.model.GeosModel;
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
			mediatorMap.mapView( TrackView, TrackMediator );
			
			// Controller.
			commandMap.mapEvent( StartGameRequest.START_GAME_REQUESTED, StartGameCommand, StartGameRequest, true );
			commandMap.mapEvent( AddObstacleRequest.ADD_OBSTACLE_REQUESTED, AddObstacleCommand, AddObstacleRequest, true );
			
			// View.
			mediatorMap.mapView( GameModule, GameMediator );
			
			super.startup();
			
			// Go go go!
			eventDispatcher.dispatchEvent( new StartGameRequest( StartGameRequest.START_GAME_REQUESTED ) );
		}
	}
}
