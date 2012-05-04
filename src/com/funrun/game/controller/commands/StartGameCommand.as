package com.funrun.game.controller.commands
{
	import com.funrun.game.controller.enum.GameType;
	
	import org.robotlegs.mvcs.Command;
	
	public class StartGameCommand extends Command
	{
		[Inject( name = "gameType" )]
		public var gameType:GameType;
		
		override public function execute():void {
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