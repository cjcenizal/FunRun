package com.funrun.services {
	
	import org.osflash.signals.Signal;
	
	import playerio.Client;
	import playerio.DatabaseObject;
	import playerio.PlayerIOError;
	
	public class WhitelistService extends JsonService implements IWhitelistService {
		
		private var _onPassSignal:Signal;
		private var _onFailSignal:Signal;
		private var _onErrorSignal:Signal;
		private var _error:Error;
		
		public function WhitelistService() {
			_onPassSignal = new Signal();
			_onFailSignal = new Signal();
			_onErrorSignal = new Signal();
		}
		
		public function isIdInTable( id:String, tableName:String, client:Client ):void {
			client.bigDB.load( tableName, id, onLoaded, onError );
		}
		
		private function onLoaded( data:DatabaseObject ):void {
			if ( data ) {
				_onPassSignal.dispatch();
			} else {
				_onFailSignal.dispatch();
			}
		}
		
		private function onError( e:PlayerIOError ):void {
			_error = e;
			_onErrorSignal.dispatch();
		}
		
		public function get onPassSignal():Signal {
			return _onPassSignal;
		}
		
		public function get onFailSignal():Signal {
			return _onFailSignal;
		}
		
		public function get onErrorSignal():Signal {
			return _onErrorSignal;
		}
		
		public function get error():Error {
			return _error;
		}
	}
}
