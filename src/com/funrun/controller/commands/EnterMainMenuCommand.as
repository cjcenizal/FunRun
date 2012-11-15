package com.funrun.controller.commands
{
	import com.funrun.controller.signals.ShowScreenRequest;
	import com.funrun.model.constants.Screen;
	import org.robotlegs.mvcs.Command;
	
	public class EnterMainMenuCommand extends Command
	{
		
		// Commands.
		
		[Inject]
		public var showScreenRequest:ShowScreenRequest;
		
		override public function execute():void
		{
			// Show main menu.
			showScreenRequest.dispatch( Screen.MAIN_MENU );
		}
	}
}