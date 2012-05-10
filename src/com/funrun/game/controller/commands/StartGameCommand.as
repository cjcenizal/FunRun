package com.funrun.game.controller.commands
{
	import com.funrun.game.controller.events.BuildTimeRequest;
	import com.funrun.game.controller.events.EnablePlayerInputRequest;
	import com.funrun.game.model.events.TimeEvent;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * StartGameCommand starts the main game loop.
	 */
	public class StartGameCommand extends Command {
		
		override public function execute():void {
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			// Respond to input.
			commandMap.mapEvent( KeyboardEvent.KEY_DOWN, KeyDownCommand, KeyboardEvent );
			commandMap.mapEvent( KeyboardEvent.KEY_UP, KeyUpCommand, KeyboardEvent );
			// Start time.
			eventDispatcher.dispatchEvent( new BuildTimeRequest( BuildTimeRequest.BUILD_TIME_REQUESTED ) );
			// Start input.
			eventDispatcher.dispatchEvent( new EnablePlayerInputRequest( EnablePlayerInputRequest.ENABLE_PLAYER_INPUT_REQUESTED ) );
		}
		
	}
}