package com.funrun.modulemanager.services
{
	public class WhitelistService implements IWhitelistService
	{
		private var _ids:Array;
		
		public function WhitelistService()
		{
			_ids = [];
			add( "2511953" );
		}
		
		public function add( id:String ):void {
			_ids.push( id );
		}
		
		public function passes( id:String ):Boolean {
			trace("passes: " + id);
			var len:int = _ids.length;
			for ( var i:int = 0; i < len; i++ ) {
				trace("   " + i + " : " + _ids[i]);
				if ( _ids[ i ] == id ) return true;
			}
			return false;
		}
	}
}