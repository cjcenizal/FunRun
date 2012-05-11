package com.funrun.game.controller.commands
{
	import com.funrun.game.controller.events.AddFloorsRequest;
	import com.funrun.game.controller.events.AddObjectToSceneRequest;
	import com.funrun.game.model.FloorsModel;
	import com.funrun.game.model.TrackModel;
	import com.funrun.game.model.constants.FloorTypes;
	import com.funrun.game.model.data.ObstacleData;
	
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