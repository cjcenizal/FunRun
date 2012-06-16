package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.SegmentData;
	import com.funrun.model.constants.SegmentTypes;
	
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
		
		override public function execute():void {
			var floor:SegmentData = segmentsModel.getOfType( SegmentTypes.FLOOR, 0 );
			floor.z = -400;
			trackModel.addSegment( floor );
			addObjectToSceneRequest.dispatch( floor.mesh );
		}
	}
}
