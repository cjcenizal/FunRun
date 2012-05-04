package com.funrun.game.controller.commands
{

	import org.robotlegs.mvcs.Command;

	/**
	 * @author CJ Cenizal.
	 * 
	 * Set up specifics for playing a local game,
	 * with fake data.
	 */
	public class StartLocalGameCommand extends Command
	{	
		override public function execute():void {
			trace(this, "start game");
			
		}
	}
}
