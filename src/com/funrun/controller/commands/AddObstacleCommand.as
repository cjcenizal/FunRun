package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddFloorRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.payload.AddFloorPayload;
	import com.funrun.model.DistanceModel;
	import com.funrun.model.FloorsModel;
	import com.funrun.model.ObstaclesModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.collision.ObstacleData;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.services.PlayerioMultiplayerService;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddObstacleCommand extends Command {
		
		[Inject]
		public var obstaclesModel:ObstaclesModel;
		
		[Inject]
		public var distanceModel:DistanceModel;
		
		[Inject]
		public var floorsModel:FloorsModel;
		
		[Inject]
		public var trackModel:TrackModel;
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var addFloorRequest:AddFloorRequest;
		
		[Inject]
		public var multiplayerService:PlayerioMultiplayerService;
		
		override public function execute():void {
			// Get an obstacle.
			var obstacle:ObstacleData = obstaclesModel.getNext();
			// Add it to the model.
			var numObstacles:int = trackModel.numObstacles;
			if ( numObstacles > 0 ) {
				obstacle.z = trackModel.depthOfLastObstacle;
			} else {
				obstacle.z = TrackConstants.TRACK_LENGTH;
			}
			trackModel.addObstacle( obstacle );
			// Add to view.
			addObjectToSceneRequest.dispatch( obstacle.mesh );
			
			// Add floors.
			var startPos:Number = obstacle.z + obstacle.bounds.max.z;
			var endPos:Number = obstacle.z + obstacle.bounds.max.z + TrackConstants.OBSTACLE_GAP;
			addFloorRequest.dispatch( new AddFloorPayload( startPos, endPos, TrackConstants.BLOCK_SIZE ) );
		}
	}
}
