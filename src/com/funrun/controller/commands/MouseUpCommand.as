package com.funrun.controller.commands
{
	import com.funrun.model.MouseModel;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class MouseUpCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var event:MouseEvent;
		
		// Models.
		
		[Inject]
		public var mouseModel:MouseModel;
		
		override public function execute():void {
			mouseModel.setMouseUp();
		}
	}
}