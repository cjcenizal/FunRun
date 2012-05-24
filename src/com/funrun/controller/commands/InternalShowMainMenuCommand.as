package com.funrun.controller.commands {

	import com.funrun.controller.events.StopGameRequest;
	import com.funrun.controller.events.StopRunningGameRequest;

	import org.robotlegs.mvcs.Command;

	public class InternalShowMainMenuCommand extends Command {

		override public function execute():void {
			eventDispatcher.dispatchEvent( new StopGameRequest( StopGameRequest.STOP_GAME_REQUESTED ) );
			eventDispatcher.dispatchEvent( new StopRunningGameRequest( StopRunningGameRequest.STOP_RUNNING_GAME_REQUEST ) );
		}
	}
}
