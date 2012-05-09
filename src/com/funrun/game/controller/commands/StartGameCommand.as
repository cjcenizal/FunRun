package com.funrun.game.controller.commands
{
	import com.funrun.game.controller.events.StartGameFulfilled;
	import com.funrun.game.model.events.TimeEvent;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * StartGameCommand starts the main game loop.
	 */
	public class StartGameCommand extends Command {
		
		override public function execute():void {
			commandMap.mapEvent( TimeEvent.TICK, UpdateGameLoopCommand, TimeEvent );
			eventDispatcher.dispatchEvent( new StartGameFulfilled( StartGameFulfilled.START_GAME_FULFILLED ) );
		}
		
	}
}