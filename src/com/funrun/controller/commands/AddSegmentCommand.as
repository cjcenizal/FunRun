package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.payload.AddSegmentPayload;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.vo.SegmentVO;
	import com.funrun.model.constants.TrackConstants;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddSegmentCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var payload:AddSegmentPayload;
		
		// Models.
		
		[Inject]
		public var segmentsModel:SegmentsModel;
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void {
			// Get an obstacle, set its position, add it to the model and view.
			var obstacle:SegmentVO = segmentsModel.getOfType( payload.type, payload.index );
			obstacle.z = payload.index * TrackConstants.SEGMENT_DEPTH;
			trackModel.addSegment( obstacle );
			addObjectToSceneRequest.dispatch( obstacle.mesh );
		}
	}
}
