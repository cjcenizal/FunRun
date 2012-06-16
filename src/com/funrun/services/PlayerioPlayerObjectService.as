package com.funrun.services {

	import org.osflash.signals.Signal;
	
	import playerio.Client;
	import playerio.DatabaseObject;
	import playerio.PlayerIOError;

	public class PlayerioPlayerObjectService {

		private var _onLoadedSignal:Signal;
		private var _onErrorSignal:Signal;
		private var _onPlayerObjectSavedSignal:Signal;
		private var _onPlayerObjectSaveErrorSignal:Signal;
		private var _playerObject:DatabaseObject;
		private var _error:PlayerIOError;
		
		public function PlayerioPlayerObjectService() {
			_onLoadedSignal = new Signal();
			_onErrorSignal = new Signal();
			_onPlayerObjectSavedSignal = new Signal();
			_onPlayerObjectSaveErrorSignal = new Signal();
		}

		public function connect( client:Client ):void {
			client.bigDB.loadMyPlayerObject( onLoaded, onError );
		}
		
		public function save( useOptimisticLocks:Boolean = false, fullOverwrite:Boolean = false ):void {
			_playerObject.save( useOptimisticLocks, fullOverwrite, onPlayerObjectSaved, onPlayerObjectSaveError );
		}
		
		private function onPlayerObjectSaved():void {
			_onPlayerObjectSavedSignal.dispatch();
		}
		
		private function onPlayerObjectSaveError( e:PlayerIOError ):void {
			_error = e;
			_onPlayerObjectSaveErrorSignal.dispatch();
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
		
		public function get onPlayerObjectSavedSignal():Signal {
			return _onPlayerObjectSavedSignal;
		}
		
		public function get onPlayerObjectSaveErrorSignal():Signal {
			return _onPlayerObjectSaveErrorSignal;
		}
		
		public function get playerObject():DatabaseObject {
			return _playerObject;
		}
		
		public function get error():PlayerIOError {
			return _error;
		}
	}
}
