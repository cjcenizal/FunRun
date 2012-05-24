package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.payload.AddFloorPayload;
	import com.funrun.model.FloorsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.ObstacleData;
	import com.funrun.model.constants.FloorTypes;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddFloorCommand extends Command {
		
		[Inject]
		public var floorsModel:FloorsModel;
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var payload:AddFloorPayload;
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void {
			var startPos:Number = payload.startPos;
			var endPos:Number = payload.endPos;
			var increment:Number = payload.increment;
			while ( startPos < endPos ) {
				var floor:ObstacleData = floorsModel.getFloorClone( FloorTypes.FLOOR );
				floor.z = startPos + increment * .5;
				trackModel.addObstacle( floor );
				addObjectToSceneRequest.dispatch( floor.mesh );
				startPos += increment;
			}
		}
	}
}
