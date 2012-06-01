package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.UpdatePlacesRequest;
	import com.funrun.model.IPlaceable;
	import com.funrun.model.PlacesModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class RemovePlaceableCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var placeable:IPlaceable;
		
		// Models.
		
		[Inject]
		public var placesModel:PlacesModel;
		
		// Commands.
		
		[Inject]
		public var updatePlacesRequest:UpdatePlacesRequest;
		
		override public function execute():void {
			placesModel.remove( placeable );
			updatePlacesRequest.dispatch();
		}
	}
}
