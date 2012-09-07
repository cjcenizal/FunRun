package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddObstaclesRequest;
	import com.funrun.controller.signals.CullTrackRequest;
	import com.funrun.model.vo.UpdateTrackVo;
	import com.funrun.model.TrackModel;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateTrackCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var payload:UpdateTrackVo;
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var cullSegmentsRequest:CullTrackRequest;
		
		[Inject]
		public var addObstaclesRequest:AddObstaclesRequest;
		
		override public function execute():void {
			cullSegmentsRequest.dispatch( payload.positionZ );
			addObstaclesRequest.dispatch( payload.positionZ );
		}
	}
}
