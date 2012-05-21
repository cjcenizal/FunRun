package com.funrun.game.controller.commands {

	import com.funrun.game.controller.events.StartGameRequest;
	import com.funrun.game.controller.events.StartRunningGameRequest;
	
	import org.robotlegs.mvcs.Command;

	public class ExternalShowGameModuleCommand extends Command {
		
		override public function execute():void {
			// Start the game.
			eventDispatcher.dispatchEvent( new StartGameRequest( StartGameRequest.START_GAME_REQUESTED ) );
			// Start running.
			eventDispatcher.dispatchEvent( new StartRunningGameRequest( StartRunningGameRequest.START_RUNNING_GAME_REQUESTED ) );
		}
	}
}
