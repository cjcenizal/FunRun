package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddFloorRequest;
	import com.funrun.controller.signals.AddObstaclesRequest;
	import com.funrun.controller.signals.DisplayDistanceRequest;
	import com.funrun.controller.signals.RemoveCompetitorRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.Track;
	import com.funrun.model.constants.Camera;
	
	import org.robotlegs.mvcs.Command;

	public class ResetGameCommand extends Command {

		// Models.
		
		[Inject]
		public var trackModel:TrackModel;

		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var nametagsModel:NametagsModel;
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		[Inject]
		public var timeModel:TimeModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		[Inject]
		public var addObstaclesRequest:AddObstaclesRequest;
		
		[Inject]
		public var addFloorRequest:AddFloorRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var removeCompetitorRequest:RemoveCompetitorRequest;
		
		[Inject]
		public var displayDistanceRequest:DisplayDistanceRequest;
		
		[Inject]
		public var view3DModel:View3DModel;
		
		override public function execute():void {
			// Reset time.
			timeModel.reset();
			// Remove all existing obstacles.
			while ( trackModel.numObstacles > 0 ) {
				removeObjectFromSceneRequest.dispatch( trackModel.getObstacleAt( 0 ).mesh );
				trackModel.removeObstacleAt( 0 );
			}
			// Remove competitors.
			while ( competitorsModel.numCompetitors > 0 ) {
				removeCompetitorRequest.dispatch( competitorsModel.getAt( 0 ) );
			}
			competitorsModel.reset();
			nametagsModel.reset();
			countdownModel.reset();
			// Reset distance.
			playerModel.position.z = 0;
			displayDistanceRequest.dispatch( playerModel.distanceString );
			// Reset player.
			resetPlayerRequest.dispatch();
			// Reset floor and obstacles.
		//	addFloorRequest.dispatch();
		//	addObstaclesRequest.dispatch( playerModel.position.z );
			// Reset camera.
			view3DModel.cameraX = 0;
			view3DModel.cameraY = Camera.Y;
			view3DModel.cameraZ = Camera.Z;
			view3DModel.cameraRotationX = Camera.TILT;
			view3DModel.cameraRotationY = 0;
			view3DModel.cameraRotationZ = 0;
			view3DModel.update();
		}
	}
}
