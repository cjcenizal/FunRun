package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.model.vo.SegmentVO;
	import com.funrun.model.constants.Segment;
	
	import org.robotlegs.mvcs.Command;

	public class AddFloorCommand extends Command {
		
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
			var floor:SegmentVO = segmentsModel.getAt( 0 );
			floor.z = Segment.FIRST_SEGMENT_Z;
			trackModel.addSegment( floor );
			addObjectToSceneRequest.dispatch( ( showBoundsState.showBounds ) ? floor.boundsMesh : floor.mesh );
		}
	}
}
