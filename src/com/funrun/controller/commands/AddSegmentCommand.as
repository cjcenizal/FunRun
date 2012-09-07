package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.state.ShowBoundsState;
	import com.funrun.model.vo.AddSegmentVo;
	import com.funrun.model.vo.BlockVo;
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
			segment.z = payload.index * ( Segment.DEPTH + Segment.GAP_BETWEEN_SEGMENTS );
			// Decorate with points.
			var point:PointVo;
			var pointMesh:Mesh;
			for ( var i:int = 0; i < segment.numPoints; i++ ) {
				point = segment.getPointAt( i );
				if ( Math.random() < .5 ) {
					//segment.addPointAt( i );
					pointMesh = point.block.mesh.clone() as Mesh;
					pointMesh.x = segment.x + point.x;
					pointMesh.y = segment.y + point.y;
					pointMesh.z = segment.z + point.z;
					addObjectToSceneRequest.dispatch( pointMesh );
				}
			}
			// Add it to the track.
			trackModel.addSegment( segment );
			// Add its mesh to the view.
			var mesh:Mesh = ( showBoundsState.showBounds ) ? segment.boundsMesh : segment.mesh;
			addObjectToSceneRequest.dispatch( mesh );
		}
	}
}
