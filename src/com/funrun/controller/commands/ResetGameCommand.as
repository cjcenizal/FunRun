package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddEmptyFloorRequest;
	import com.funrun.controller.signals.AddObstaclesRequest;
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TrackModel;
	
	import org.robotlegs.mvcs.Command;

	public class ResetGameCommand extends Command {

		// Models.
		
		[Inject]
		public var trackModel:TrackModel;

		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		[Inject]
		public var addObstaclesRequest:AddObstaclesRequest;
		
		[Inject]
		public var addEmptyFloorRequest:AddEmptyFloorRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var displayDistanceRequest:DisplayDistanceRequest;
		
		override public function execute():void {
			// Remove all existing obstacles.
			while ( trackModel.numObstacles > 0 ) {
				removeObjectFromSceneRequest.dispatch( trackModel.getObstacleAt( 0 ).mesh );
				trackModel.removeObstacleAt( 0 );
			}
			// Reset distance.
			playerModel.positionZ = 0;
			displayDistanceRequest.dispatch( playerModel.distanceString );
			// Reset player.
			resetPlayerRequest.dispatch();
			// Reset floor and obstacles.
			addEmptyFloorRequest.dispatch();
			addObstaclesRequest.dispatch( playerModel.positionZ );
			
		}
	}
}
