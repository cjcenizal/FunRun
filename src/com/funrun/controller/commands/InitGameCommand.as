package com.funrun.controller.commands
{
	import org.robotlegs.utilities.macrobot.SequenceCommand;
	
	public class InitGameCommand extends SequenceCommand {
		
		public function InitGameCommand() {
			// Load and parse all data files.
			addCommand( BuildGameDataCommand );
			// Build the game, using the game data.
			addCommand( BuildGameCommand );
		}
	}
}