package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.ClearReadyListRequest;
	import com.funrun.controller.signals.DrawPointsRequest;
	import com.funrun.controller.signals.RemoveCompetitorRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
	import com.funrun.controller.signals.ResetPlayerRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.SegmentsModel;
	import com.funrun.model.StateModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.TrackModel;
	import com.funrun.model.View3dModel;
	
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
		
		[Inject]
		public var segmentModel:SegmentsModel;
		
		[Inject]
		public var keyboardModel:KeyboardModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var stateModel:StateModel;
		
		// Commands.
		
		[Inject]
		public var resetPlayerRequest:ResetPlayerRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var removeCompetitorRequest:RemoveCompetitorRequest;
		
		[Inject]
		public var drawPointsRequest:DrawPointsRequest;
		
		[Inject]
		public var clearReadyListRequest:ClearReadyListRequest;
		
		override public function execute():void {
			stateModel.canMoveForward = false;
			stateModel.canDie = true;
			
			// Reset time.
			timeModel.reset();
			// Remove all existing obstacles.
			while ( trackModel.numSegments > 0 ) {
				removeObjectFromSceneRequest.dispatch( ( gameModel.showBounds ) ? trackModel.getSegmentAt( 0 ).boundsMesh : trackModel.getSegmentAt( 0 ).mesh );
				trackModel.removeSegmentAt( 0 );
			}
			// Remove points.
			while ( pointsModel.numPoints > 0 ) {
				removeObjectFromSceneRequest.dispatch( pointsModel.getPointAt( 0 ).mesh );
				pointsModel.removePointAt( 0 );
			}
			// Remove competitors.
			while ( competitorsModel.numCompetitors > 0 ) {
				removeCompetitorRequest.dispatch( competitorsModel.getAt( 0 ) );
			}
			keyboardModel.reset();
			competitorsModel.reset();
			nametagsModel.reset();
			countdownModel.reset();
			pointsModel.reset();
			segmentModel.reset();
			// Reset distance.
			playerModel.position.z = 0;
			drawPointsRequest.dispatch( 0 );
			// Reset player.
			resetPlayerRequest.dispatch( true );
			// Reset UI.
			clearReadyListRequest.dispatch();
		}
	}
}
