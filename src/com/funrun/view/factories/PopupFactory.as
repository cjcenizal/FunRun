package com.funrun.view.factories {

	import com.funrun.model.DistanceModel;
	import com.funrun.model.constants.PopupTypes;
	import com.funrun.view.components.Popup;
	import com.funrun.view.components.ResultsPopup;

	public class PopupFactory {
		
		[Inject]
		public var distanceModel:DistanceModel;
		
		public function build( type:String ):Popup {
			switch ( type ) {
				case PopupTypes.RESULTS:
					return buildResultsPopup();
			}
			return null;
		}

		private function buildResultsPopup():ResultsPopup {
			return new ResultsPopup( "You ran " + distanceModel.distanceString() + " feet!" );
		}
	}
}
