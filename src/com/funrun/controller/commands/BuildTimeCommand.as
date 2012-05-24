package com.funrun.controller.commands
{
	import com.funrun.model.TimeModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class BuildTimeCommand extends Command
	{
		[Inject]
		public var model:TimeModel;
		
		override public function execute():void {
			model.stage = contextView.stage;
			model.start();
		}
	}
}