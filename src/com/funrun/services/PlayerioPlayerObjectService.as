package com.funrun.services {

	import org.osflash.signals.Signal;
	
	import playerio.Client;
	import playerio.DatabaseObject;
	import playerio.PlayerIOError;

	public class PlayerioPlayerObjectService {

		private var _onLoadedSignal:Signal;
		private var _onErrorSignal:Signal;
		private var _playerObject:DatabaseObject;
		private var _error:PlayerIOError;
		
		public function PlayerioPlayerObjectService() {
			_onLoadedSignal = new Signal();
			_onErrorSignal = new Signal();
		}

		public function load( client:Client ):void {
			client.bigDB.loadMyPlayerObject( onLoaded, onError );
		}
		
		private function onLoaded( playerObject:DatabaseObject ):void {
			_playerObject = playerObject;
			_onLoadedSignal.dispatch();
		}
		
		private function onError( e:PlayerIOError ):void {
			_error = e;
			_onErrorSignal.dispatch();
		}
		
		public function get onLoadedSignal():Signal {
			return _onLoadedSignal;
		}
		
		public function get onErrorSignal():Signal {
			return _onErrorSignal;
		}
		
		public function get playerObject():DatabaseObject {
			return _playerObject;
		}
		
		public function get error():PlayerIOError {
			return _error;
		}
	}
}
