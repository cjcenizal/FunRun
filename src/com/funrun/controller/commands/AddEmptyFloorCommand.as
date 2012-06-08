package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.model.FloorsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.ObstacleData;
	import com.funrun.model.constants.FloorTypes;
	
	import org.robotlegs.mvcs.Command;

	public class AddEmptyFloorCommand extends Command {
		
		// Models.
		
		[Inject]
		public var floorsModel:FloorsModel;
		
		[Inject]
		public var trackModel:TrackModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void {
			var floor:ObstacleData = floorsModel.getFloorClone( FloorTypes.FLOOR );
			floor.z = -400;
			trackModel.addObstacle( floor );
			addObjectToSceneRequest.dispatch( floor.mesh );
		}
	}
}
