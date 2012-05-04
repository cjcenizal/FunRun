package com.funrun.game
{
	
	import com.funrun.game.controller.commands.StartGameCommand;
	import com.funrun.game.controller.enum.GameType;
	import com.funrun.game.controller.events.StartGameRequestEvent;
	import com.funrun.game.view.components.Track;
	import com.funrun.game.view.mediators.TrackMediator;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	import org.robotlegs.base.ContextEvent;
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
			mediatorMap.mapView( Track, TrackMediator );
			
			// Controller.
			commandMap.mapEvent( StartGameRequestEvent.START_GAME_REQUESTED, StartGameCommand, StartGameRequestEvent, true );
			
			// View.
			mediatorMap.mapView( GameModule, GameMediator );
			
			// Let's get started!
			eventDispatcher.dispatchEvent( new StartGameRequestEvent( StartGameRequestEvent.START_GAME_REQUESTED ) );
			
			super.startup();
			
			dispatchEvent( new ContextEvent( ContextEvent.STARTUP ) );
		}
	}
}
