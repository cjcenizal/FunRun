package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddObstaclesRequest;
	import com.funrun.controller.signals.CullSegmentsRequest;
	import com.funrun.controller.signals.payload.UpdateTrackPayload;
	import com.funrun.model.TrackModel;
	
	import org.robotlegs.mvcs.Command;

	public class UpdateTrackCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var payload:UpdateTrackPayload;
		
		// Models.
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var cullSegmentsRequest:CullSegmentsRequest;
		
		[Inject]
		public var addObstaclesRequest:AddObstaclesRequest;
		
		override public function execute():void {
			cullSegmentsRequest.dispatch( payload.positionZ );
			addObstaclesRequest.dispatch( payload.positionZ );
		}
	}
}
