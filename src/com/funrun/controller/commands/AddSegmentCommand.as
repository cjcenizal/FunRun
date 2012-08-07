package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.payload.AddSegmentPayload;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.model.vo.SegmentVO;
	
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
		
		// State.
		
		[Inject]
		public var showBoundsState:ShowBoundsState;
		
		override public function execute():void {
			// Get an obstacle, set its position, add it to the model and view.
			var obstacle:SegmentVO = segmentsModel.getAt( payload.index );
			obstacle.z = payload.index * Segment.SEGMENT_DEPTH;
			trackModel.addSegment( obstacle );
			addObjectToSceneRequest.dispatch( ( showBoundsState ) ? obstacle.boundsMesh : obstacle.mesh );
		}
	}
}
