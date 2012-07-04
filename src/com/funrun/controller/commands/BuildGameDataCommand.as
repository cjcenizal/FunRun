package com.funrun.controller.commands {

	import org.robotlegs.utilities.macrobot.SequenceCommand;

	public class BuildGameDataCommand extends SequenceCommand {
		
		public function BuildGameDataCommand() {
			// Load all blocks.
			addCommand( LoadBlocksCommand );
			// Load list of obstacles, and then load each obstacle.
			addCommand( LoadObstaclesCommand );
		}
	}
}
