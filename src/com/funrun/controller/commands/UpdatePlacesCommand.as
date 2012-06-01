package com.funrun.controller.commands {

	import com.funrun.model.PlacesModel;
	
	import org.robotlegs.mvcs.Command;

	public class UpdatePlacesCommand extends Command {
		
		// Models.
		
		[Inject]
		public var placesModel:PlacesModel;
		
		override public function execute():void {
			placesModel.sortPlaces();
			// TO-DO: Update UI.
		}
	}
}
