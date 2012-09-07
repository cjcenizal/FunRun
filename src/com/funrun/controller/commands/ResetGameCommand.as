package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.DrawDistanceRequest;
	import com.funrun.controller.signals.RemoveCompetitorRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.View3dModel;
	import com.funrun.model.state.ShowBoundsState;
	
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
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var pointsModel:PointsModel;
		
		// Commands.
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var removeCompetitorRequest:RemoveCompetitorRequest;
		
		[Inject]
		public var displayDistanceRequest:DrawDistanceRequest;
		
		// State.
		
		[Inject]
		public var showBoundsState:ShowBoundsState;
		
		override public function execute():void {
			// Reset time.
			timeModel.reset();
			// Remove all existing obstacles.
			while ( trackModel.numObstacles > 0 ) {
				removeObjectFromSceneRequest.dispatch( ( showBoundsState.showBounds ) ? trackModel.getObstacleAt( 0 ).boundsMesh : trackModel.getObstacleAt( 0 ).mesh );
				trackModel.removeObstacleAt( 0 );
			}
			// Remove competitors.
			while ( competitorsModel.numCompetitors > 0 ) {
				removeCompetitorRequest.dispatch( competitorsModel.getAt( 0 ) );
			}
			competitorsModel.reset();
			nametagsModel.reset();
			countdownModel.reset();
			pointsModel.reset();
			// Reset distance.
			playerModel.position.z = 0;
			displayDistanceRequest.dispatch( playerModel.distanceString );
			// Reset player.
			resetPlayerRequest.dispatch( true );
		}
	}
}
