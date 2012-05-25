package com.funrun.model {

	import com.funrun.view.components.Popup;
	
	import org.robotlegs.mvcs.Actor;

	public class PopupsModel extends Actor {
		
		private var _popups:Object = {};

		public function hasPopup( type:String ):Boolean {
			return _popups[ type ];
		}
		
		public function getPopup( type:String ):Popup {
			return _popups[ type ];
		}
		
		public function addPopup( type:String, popup:Popup ):Popup {
			_popups[ type ] = popup;
			return popup;
		}
		
		public function removePopup( type:String ):Popup {
			var popup:Popup = _popups[ type ];
			delete _popups[ type ];
			return popup;
		}
	}
}
