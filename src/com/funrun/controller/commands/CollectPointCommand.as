package com.funrun.controller.commands
{
	import com.funrun.model.vo.CollectPointVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class CollectPointCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var vo:CollectPointVo;
		
		override public function execute():void {
			trace(vo.segmentId, vo.blockId);
		}
	}
}