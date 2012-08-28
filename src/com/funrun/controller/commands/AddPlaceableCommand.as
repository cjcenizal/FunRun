package com.funrun.controller.commands {

	import com.funrun.model.vo.IPlaceable;
	import com.funrun.model.PlacesModel;

	import org.robotlegs.mvcs.Command;

	public class AddPlaceableCommand extends Command {

		// Arguments.

		[Inject]
		public var placeable:IPlaceable;

		// Models.

		[Inject]
		public var placesModel:PlacesModel;

		// Commands.

	//	[Inject]
	//	public var updatePlacesRequest:UpdatePlacesRequest;

		override public function execute():void {
			placesModel.add( placeable );
	//		updatePlacesRequest.dispatch();
		}
	}
}
