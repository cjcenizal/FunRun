package com.funrun.view.factories {

	import com.funrun.model.constants.PopupTypes;
	import com.funrun.view.components.Popup;
	import com.funrun.view.components.ResultsPopup;

	public class PopupFactory {
		
		public static function build( type:String ):Popup {
			switch ( type ) {
				case PopupTypes.RESULTS:
					return buildResultsPopup();
			}
			return null;
		}

		private static function buildResultsPopup():ResultsPopup {
			return new ResultsPopup();
		}
	}
}
