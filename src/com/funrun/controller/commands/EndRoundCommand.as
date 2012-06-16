package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddPopupRequest;
	import com.funrun.controller.signals.SavePlayerObjectRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.vo.ResultsPopupVO;
	import com.funrun.view.components.ResultsPopup;
	
	import org.robotlegs.mvcs.Command;
	
	public class EndRoundCommand extends Command {
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var addPopupRequest:AddPopupRequest;
		
		[Inject]
		public var savePlayerObjectRequest:SavePlayerObjectRequest;
		
		override public function execute():void {
			// Show popup.
			var message:String = "You ran " + playerModel.distanceString + " feet!";
			if ( playerModel.distanceInFeet > playerModel.bestDistance ) {
				message += "<br>This is your new best distance!";
			} else {
				message += "<br>Your best distance so far is " + playerModel.bestDistance.toString();
			}
			addPopupRequest.dispatch( new ResultsPopup(
				new ResultsPopupVO( message ) ) );
			
			// Assign new best distance and save.
			playerModel.bestDistance = playerModel.distanceInFeet;
			savePlayerObjectRequest.dispatch();
		}
	}
}
