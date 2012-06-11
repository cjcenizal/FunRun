package com.funrun.controller.commands {

	import com.funrun.controller.signals.DisplayPlaceRequest;
	import com.funrun.model.PlacesModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.services.OrdinalizeNumberService;
	
	import org.robotlegs.mvcs.Command;

	public class UpdatePlacesCommand extends Command {
		
		// Models.
		
		[Inject]
		public var placesModel:PlacesModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Services.
		
		[Inject]
		public var ordinalizeNumberService:OrdinalizeNumberService;
		
		// Commands.
		
		[Inject]
		public var displayPlaceRequest:DisplayPlaceRequest;
		
		override public function execute():void {
			placesModel.sortPlaces();
			displayPlaceRequest.dispatch( ordinalizeNumberService.ordinalize( playerModel.place ) );
		}
	}
}
