package com.funrun.controller.commands
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class MouseWheelCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var event:MouseEvent;
		
		override public function execute():void {
			
		}
	}
}