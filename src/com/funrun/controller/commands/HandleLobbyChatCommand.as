package com.funrun.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;
	
	public class HandleLobbyChatCommand extends Command
	{
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		override public function execute():void
		{
			trace(message);
		}
	}
}