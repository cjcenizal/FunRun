package com.funrun.controller.commands
{
	import com.cenizal.utils.Console;
	import com.funrun.model.GameModel;
	import com.funrun.controller.signals.vo.LogMessageVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class LogMessageCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var vo:LogMessageVo;
		
		// State.
		
		[Inject]
		public var productionState:GameModel;
		
		// Services.
		
		[Inject]
		public var console:Console;
		
		override public function execute():void {
			trace(vo.source, ": ", vo.message);
			if ( !productionState.isProduction ) {
				console.log( vo.source, vo.message );
			}
		}
	}
}