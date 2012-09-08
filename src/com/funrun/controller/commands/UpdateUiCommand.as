package com.funrun.controller.commands
{
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.DrawCountdownRequest;
	import com.funrun.controller.signals.DrawPointsRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.controller.signals.UpdateAiCompetitorsRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.PlacesModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.StateModel;
	import com.funrun.model.View3dModel;
	import com.funrun.model.vo.CompetitorVo;
	import com.funrun.services.OrdinalizeNumberService;
	
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateUiCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var stateModel:StateModel;
		
		[Inject]
		public var countdownModel:CountdownModel;
		
		[Inject]
		public var placesModel:PlacesModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var nametagsModel:NametagsModel;
		
		[Inject]
		public var view3DModel:View3dModel;
		
		[Inject]
		public var pointsModel:PointsModel;
		
		// Services.
		
		[Inject]
		public var ordinalizeNumberService:OrdinalizeNumberService;
		
		// Commands.
		
		[Inject]
		public var updateAiCompetitorsRequest:UpdateAiCompetitorsRequest;
		
		[Inject]
		public var drawCountdownRequest:DrawCountdownRequest;
		
		[Inject]
		public var startRunningRequest:StartRunningRequest;
		
		[Inject]
		public var drawPointsRequest:DrawPointsRequest;
		
		override public function execute():void {
			updateCountdown();
			updatePlaces();
			updateNametags();
			updatePoints();
		}
		
		private function updateCountdown():void {
			if ( stateModel.isWaitingForPlayers() ) {
				if ( countdownModel.isRunning ) {
					if ( countdownModel.secondsRemaining > 0 ) {
						// Continue the countdown.
						drawCountdownRequest.dispatch( countdownModel.secondsRemaining.toString() );
					} else {
						// Start running.
						startRunningRequest.dispatch();
					}
				}
			}
		}
		
		private function updatePlaces():void {
			// TO-DO: Is this necessary?
			placesModel.sortPlaces();
		}
		
		private function updateNametags():void {
			// Interpolate competitor position.
			var len:int = competitorsModel.numCompetitors;
			var competitor:CompetitorVo;
			var nametag:AbstractLabel;
			for ( var i:int = 0; i < len; i++ ) {
				competitor = competitorsModel.getAt( i );
				// Only show nametag if the competitor is in front of the player.
				nametag = nametagsModel.getWithId( competitor.id.toString() );
				if ( nametag ) {
					if ( playerModel.position.z - competitor.position.z < 300 ) {
						var pos:Point = view3DModel.project( competitor.mesh.position );
						nametag.x = pos.x;
						nametag.y = pos.y;
					} else {
						nametag.x = -500;
					}
				}
			}
		}
		
		private function updatePoints():void {
			if ( stateModel.isRunning() ) {
				drawPointsRequest.dispatch( pointsModel.amount.toString() );
			}
		}
	}
}