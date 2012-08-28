package com.funrun.controller.commands
{
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.controller.signals.DrawCountdownRequest;
	import com.funrun.controller.signals.DrawDistanceRequest;
	import com.funrun.controller.signals.DrawPlaceRequest;
	import com.funrun.controller.signals.StartRunningRequest;
	import com.funrun.controller.signals.UpdateAiCompetitorsRequest;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.CountdownModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.PlacesModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.state.GameState;
	import com.funrun.model.vo.CompetitorVO;
	import com.funrun.services.OrdinalizeNumberService;
	
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateUiCommand extends Command
	{
		
		// State.
		
		[Inject]
		public var gameState:GameState;
		
		// Models.
		
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
		public var view3DModel:View3DModel;
		
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
		public var drawPlacesRequest:DrawPlaceRequest;
		
		[Inject]
		public var drawDistanceRequest:DrawDistanceRequest;
		
		override public function execute():void {
			updateCountdown();
			updatePlaces();
			updateNametags();
			updateDistance();
		}
		
		private function updateCountdown():void {
			if ( gameState.gameState == GameState.WAITING_FOR_PLAYERS ) {
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
			placesModel.sortPlaces();
			drawPlacesRequest.dispatch( ordinalizeNumberService.ordinalize( playerModel.place ) );
		}
		
		private function updateNametags():void {
			// Interpolate competitor position.
			var len:int = competitorsModel.numCompetitors;
			var competitor:CompetitorVO;
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
		
		private function updateDistance():void {
			// Update distance counter.
			if ( gameState.gameState == GameState.RUNNING ) {
				drawDistanceRequest.dispatch( playerModel.distanceString + " feet" );
			}
		}
	}
}