package com.funrun.services {

	import org.robotlegs.mvcs.Actor;

	public class OrdinalizeNumberService {
		
		private var _suffixes:Object;
		
		public function OrdinalizeNumberService() {
			_suffixes = {};
			_suffixes[ 0 ] = "th";
			_suffixes[ 1 ] = "st";
			_suffixes[ 2 ] = "nd";
			_suffixes[ 3 ] = "rd";
			_suffixes[ 4 ] = "th";
			_suffixes[ 5 ] = "th";
			_suffixes[ 6 ] = "th";
			_suffixes[ 7 ] = "th";
			_suffixes[ 8 ] = "th";
			_suffixes[ 9 ] = "th";
		}
		
		public function ordinalize( val:Number ):String {
			var valString:String = val.toString();
			var suffix:String = _suffixes[ valString.substr( valString.length-1, valString.length ) ];
			return val.toString() + suffix;
		}
		
	}
}
