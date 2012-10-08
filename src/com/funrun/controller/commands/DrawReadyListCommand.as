package com.funrun.controller.commands
{
	import com.funrun.controller.signals.AddToReadyListRequest;
	import com.funrun.controller.signals.ClearReadyListRequest;
	import com.funrun.controller.signals.vo.AddToReadyListVo;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.vo.CompetitorVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class DrawReadyListCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var addToReadyListRequest:AddToReadyListRequest;
		
		[Inject]
		public var clearReadyListRequest:ClearReadyListRequest;
		
		override public function execute():void
		{
			clearReadyListRequest.dispatch();
			for ( var i:int = 0; i < competitorsModel.numCompetitors; i++ ) {
				var vo:CompetitorVo = competitorsModel.getAt( i );
				addToReadyListRequest.dispatch( new AddToReadyListVo( vo.id, vo.name, vo.isReady ) );
			}
		}
	}
}