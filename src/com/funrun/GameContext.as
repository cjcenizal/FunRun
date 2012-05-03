package com.funrun
{
	
	import com.funrun.controller.commands.StartGameCommand;
	import com.funrun.controller.enum.GameType;
	import com.funrun.controller.events.StartGameRequestEvent;
	import com.funrun.view.components.Track;
	import com.funrun.view.mediators.ApplicationMediator;
	import com.funrun.view.mediators.TrackMediator;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	import org.robotlegs.core.IContext;
	import org.robotlegs.mvcs.Context;
	
	public class GameContext extends Context implements IContext
	{
		
		public function GameContext( contextView:DisplayObjectContainer, autoStartup:Boolean ) {
			super( contextView, autoStartup );
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
			mediatorMap.mapView( FunRun, ApplicationMediator );
			
			// Let's get started!
			eventDispatcher.dispatchEvent( new StartGameRequestEvent( StartGameRequestEvent.START_GAME_REQUESTED ) );
			
			super.startup();
		}
	}
}
