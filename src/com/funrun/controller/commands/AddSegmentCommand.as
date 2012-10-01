package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.PointsModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.controller.signals.vo.AddSegmentVo;
	import com.funrun.model.vo.PointVo;
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
		
		[Inject]
		public var pointsModel:PointsModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		// State.
		
		[Inject]
		public var showBoundsState:ShowBoundsState;
		
		override public function execute():void {
			// Get a segment from the model for our current position.
			var segment:SegmentVo = segmentsModel.getAt( payload.index );
			// Position it.
			segment.z = payload.index * Segment.DEPTH;
			// Decorate with points.
			var point:PointVo;
			for ( var i:int = 0; i < segment.numPoints; i++ ) {
				point = segment.getPointAt( i ).clone();
				//if ( pointsModel.shouldHavePointFor( segment.id, point.id, segment.numPoints ) ) {
					point.mesh = point.block.mesh.clone() as Mesh;
					point.mesh.x = segment.x + point.x;
					point.mesh.y = segment.y + point.y;
					point.mesh.z = segment.z + point.z;
					point.segmentId = segment.id;
					pointsModel.addPoint( point );
					addObjectToSceneRequest.dispatch( point.mesh );
				//}
			}
			// Add it to the track.
			trackModel.addSegment( segment );
			// Add its mesh to the view.
			var mesh:Mesh = ( showBoundsState.showBounds ) ? segment.boundsMesh : segment.mesh;
			addObjectToSceneRequest.dispatch( mesh );
		}
	}
}
