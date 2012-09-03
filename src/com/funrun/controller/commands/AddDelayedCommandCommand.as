package com.funrun.controller.commands {

	import com.funrun.model.vo.AddDelayedCommandVo;
	import com.funrun.model.DelayedCommandsModel;
	
	import org.robotlegs.mvcs.Command;

	public class AddDelayedCommandCommand extends Command {

		// Arguments.
		
		[Inject]
		public var payload:AddDelayedCommandVo;
		
		// Models.
		
		[Inject]
		public var delayedCommandsModel:DelayedCommandsModel;
		
		override public function execute():void {
			// How do we pass args?
			delayedCommandsModel.add( payload.signal, payload.delayMs, payload.arg );
		}
	}
}
