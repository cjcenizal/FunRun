package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.vo.AddSegmentVo;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.model.vo.SegmentVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddSegmentCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var payload:AddSegmentVo;
		
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
			var obstacle:SegmentVo = segmentsModel.getAt( payload.index );
			obstacle.z = payload.index * ( Segment.DEPTH + Segment.GAP_BETWEEN_SEGMENTS );
			trackModel.addSegment( obstacle );
			var mesh:Mesh = ( showBoundsState.showBounds ) ? obstacle.boundsMesh : obstacle.mesh;
			addObjectToSceneRequest.dispatch( mesh );
		}
	}
}
