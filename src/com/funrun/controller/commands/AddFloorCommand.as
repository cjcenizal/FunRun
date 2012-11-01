package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.vo.SegmentVo;
	
	import org.robotlegs.mvcs.Command;

	public class AddFloorCommand extends Command {
		
		// Models.
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		[Inject]
		public var segmentsModel:SegmentsModel;
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		// State.
		
		override public function execute():void {
			var floor:SegmentVo = segmentsModel.getAt( blockStylesModel.currentStyle.id, 0 );
			trackModel.addSegment( floor );
			addObjectToSceneRequest.dispatch( ( gameModel.showBounds ) ? floor.boundsMesh : floor.mesh );
		}
	}
}
