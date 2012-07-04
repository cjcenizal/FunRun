package com.funrun.controller.commands {

	import org.robotlegs.utilities.macrobot.AsyncCommand;
	import org.robotlegs.utilities.macrobot.ParallelCommand;

	public class BuildGameDataCommand extends ParallelCommand {
		
		public function BuildGameDataCommand() {
			// Load all blocks.
			addCommand( LoadBlocksCommand );
			// Load list of obstacles, and then load each obstacle.
			addCommand( LoadObstaclesCommand );
		}
	}
}
