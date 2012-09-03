package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.model.vo.SegmentVo;
	
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
			var floor:SegmentVo = segmentsModel.getAt( 0 );
			trackModel.addSegment( floor );
			addObjectToSceneRequest.dispatch( ( showBoundsState.showBounds ) ? floor.boundsMesh : floor.mesh );
		}
	}
}
