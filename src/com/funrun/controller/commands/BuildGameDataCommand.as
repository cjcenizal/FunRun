package com.funrun.controller.commands {

	import org.robotlegs.utilities.macrobot.SequenceCommand;

	public class BuildGameDataCommand extends SequenceCommand {
		
		public function BuildGameDataCommand() {
			// Load config
			addCommand( LoadConfigCommand );
			// Load block types.
			addCommand( LoadBlockTypesCommand );
			// Load block styles.
			addCommand( LoadBlockStylesCommand );
			// Load list of obstacles, and then load each obstacle.
			addCommand( LoadObstaclesCommand );
			// Load store.
			addCommand( LoadCharactersCommand );
			// Load store.
			addCommand( LoadStoreCommand );
			// Preload.
			addCommand( PreloadSoundsCommand );
		}
	}
}
