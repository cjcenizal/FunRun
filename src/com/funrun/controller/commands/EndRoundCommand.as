package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.controller.signals.SavePlayerObjectRequest;
	import com.funrun.controller.signals.StopGameLoopRequest;
	import com.funrun.controller.signals.vo.ResultsPopupVo;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.GameModel;
	import com.funrun.model.PlacesModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.RewardsModel;
	import com.funrun.view.components.ResultsPopup;
	
	import org.robotlegs.mvcs.Command;
	
	public class EndRoundCommand extends Command {
		
		// Models.
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var placesModel:PlacesModel;
		
		[Inject]
		public var rewardsModel:RewardsModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var stopGameLoopRequest:StopGameLoopRequest;
		
		[Inject]
		public var addPopupRequest:AddPopupRequest;
		
		[Inject]
		public var savePlayerObjectRequest:SavePlayerObjectRequest;
		
		override public function execute():void {
			// Stop game loop.
			stopGameLoopRequest.dispatch();
			
			// Show popup.
			var message:String = "You ran " + playerModel.distanceString + " feet!";
			if ( playerModel.distanceInFeet > playerModel.highScore ) {
				message += "<br>This is your new best distance!";
			} else {
				message += "<br>Your best distance so far is " + playerModel.highScore.toString();
			}
			addPopupRequest.dispatch( new ResultsPopup( new ResultsPopupVo( message ) ) );
			
			// Show places.
			var orderedByPlace:Array = [];
			for ( var i:int = 0; i < competitorsModel.numCompetitors; i++ ) {
				orderedByPlace.push( { "place" : competitorsModel.getAt( i ).place, "name" : competitorsModel.getAt( i ).name } );
			}
			orderedByPlace.push( { "place" : playerModel.place, "name" : "You" } );
			orderedByPlace.sortOn( "place", Array.NUMERIC );
			
			if ( gameModel.isMultiplayer ) {
				// Assign new best distance, points, and save.
				if ( playerModel.distanceInFeet > playerModel.highScore ) {
					playerModel.highScore = playerModel.distanceInFeet;
				}
				playerModel.points += rewardsModel.retrieveRewardFor( playerModel.place - 1 );
				savePlayerObjectRequest.dispatch();
			}
		}
	}
}
