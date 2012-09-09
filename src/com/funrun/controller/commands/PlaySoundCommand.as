package com.funrun.controller.commands
{
	import com.funrun.model.SoundsModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class PlaySoundCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var id:String;
		
		// Models.
		
		[Inject]
		public var soundsModel:SoundsModel;
		
		override public function execute():void
		{
			
		}
	}
}