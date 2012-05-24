package com.funrun.controller.commands
{
	import com.funrun.controller.events.AddFloorsRequest;
	import com.funrun.controller.events.AddObjectToSceneRequest;
	import com.funrun.model.FloorsModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.constants.FloorTypes;
	import com.funrun.model.collision.ObstacleData;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddFloorsCommand extends Command
	{
		
		[Inject]
		public var floorsModel:FloorsModel;
		
		[Inject]
		public var trackModel:TrackModel;

		[Inject]
		public var event:AddFloorsRequest;
		
		override public function execute():void {
			var startPos:Number = this.event.startPos;
			var endPos:Number = this.event.endPos;
			var increment:Number = this.event.increment;
			while ( startPos < endPos ) {
				var floor:ObstacleData = floorsModel.getFloorClone( FloorTypes.FLOOR );
				floor.z = startPos + increment * .5;
				trackModel.addObstacle( floor );
				var event:AddObjectToSceneRequest = new AddObjectToSceneRequest( AddObjectToSceneRequest.ADD_OBSTACLE_TO_SCENE_REQUESTED, floor.mesh );
				eventDispatcher.dispatchEvent( event );
				startPos += increment;
			}
		}
	}
}