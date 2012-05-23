package com.funrun.modulemanager.services {
	
	public class WhitelistService implements IWhitelistService {
		
		private var _ids:Array;
		
		public function WhitelistService() {
			_ids = [];
		}
		
		public function add( id:String ):void {
			_ids.push( id );
		}
		
		public function passes( id:String ):Boolean {
			var len:int = _ids.length;
			for ( var i:int = 0; i < len; i++ ) {
				if ( _ids[ i ] == id ) {
					return true;
				}
			}
			return false;
		}
	}
}
