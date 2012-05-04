package com.funrun.game.controller.commands
{
	import com.funrun.game.controller.events.StartGameFulfilled;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * StartGameCommand starts the main game loop.
	 */
	public class StartGameCommand extends Command {
		
		override public function execute():void {
			eventDispatcher.dispatchEvent( new StartGameFulfilled( StartGameFulfilled.START_GAME_FULFILLED ) );
		}
		
	}
}