package com.funrun.controller.commands
{
	import com.funrun.controller.enum.GameType;
	
	import org.robotlegs.mvcs.Command;
	
	public class StartGameCommand extends Command
	{
		[Inject( name = "gameType" )]
		public var gameType:GameType
		
		override public function execute():void {
			// Build dependencies, game, and configure game.
			switch ( gameType.type ) {
				case GameType.Local.type:
					commandMap.execute( StartLocalGameCommand );
					break;
				case GameType.Production.type:
					break;
			}	
		}
	}
}