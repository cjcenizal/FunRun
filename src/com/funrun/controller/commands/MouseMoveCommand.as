package com.funrun.controller.commands
{
	import com.funrun.model.MouseModel;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class MouseMoveCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var event:MouseEvent;
		
		// Models.
		
		[Inject]
		public var mouseModel:com.funrun.model.MouseModel;
		
		override public function execute():void {
			// Update mouse.
			mouseModel.moveMouse( contextView.stage.mouseX, contextView.stage.mouseY );

		}
	}
}