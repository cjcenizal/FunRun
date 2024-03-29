package com.funrun.controller.commands {
	
	import away3d.entities.Mesh;
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.vo.AddSegmentVo;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.vo.PointVo;
	import com.funrun.model.vo.SegmentVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddSegmentCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var payload:AddSegmentVo;
		
		// Models.
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		[Inject]
		public var segmentsModel:SegmentsModel;
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var pointsModel:PointsModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		// State.
		
		override public function execute():void {
			// Get a segment from the model for our current position.
			var segment:SegmentVo = segmentsModel.getAt( blockStylesModel.currentStyle.id, payload.index );
			// Position it.
			segment.z = payload.index * Segment.DEPTH;
			// Decorate with points.
			var point:PointVo;
			for ( var i:int = 0; i < segment.numPoints; i++ ) {
				point = segment.getPointAt( i ).clone();
				//if ( pointsModel.shouldHavePointFor( segment.id, point.id, segment.numPoints ) ) {
					point.mesh = blockStylesModel.getMeshCloneForBlock( point.block.id );//point.block.mesh.clone() as Mesh;
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
			var mesh:Mesh = ( gameModel.showBounds ) ? segment.boundsMesh : segment.mesh;
			addObjectToSceneRequest.dispatch( mesh );
		}
	}
}
