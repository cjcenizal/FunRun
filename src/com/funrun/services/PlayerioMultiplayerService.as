package com.funrun.services {

	import org.osflash.signals.Signal;
	
	import playerio.Client;
	import playerio.Connection;
	import playerio.Message;
	import playerio.PlayerIOError;

	public class PlayerioMultiplayerService {
		
		private var _connection:Connection;
		private var _error:PlayerIOError;
		private var _onConnectedSignal:Signal;
		private var _onErrorSignal:Signal;
		private var _isConnected:Boolean = false;

		public function PlayerioMultiplayerService() {
			_onConnectedSignal = new Signal();
			_onErrorSignal = new Signal();
		}

		public function connect( client:Client, roomType:String, userJoinData:Object = null, roomId:String = "$service-room$" ):void {
			userJoinData = userJoinData || {};
			var visibleToLobby:Boolean = true; // Should the room be visible in a listRooms() call?
			var roomData:Object = {}; // Room data. This data is returned to lobby list. Variables can be modifed on the server.
			client.multiplayer.createJoinRoom( roomId, roomType, visibleToLobby, roomData, userJoinData, onRoomJoinSuccess, onError );
		}

		public function disconnect():void {
			// TO-DO: Disconnect.
		}
		
		private function onRoomJoinSuccess( connection:Connection ):void {
			_connection = connection;
			_isConnected = true;
			_onConnectedSignal.dispatch();
		}

		private function onError( error:PlayerIOError ):void {
			_error = error;
			_onErrorSignal.dispatch();
		}

		public function get isConnected():Boolean {
			return _isConnected;
		}
		
		public function get onConnectedSignal():Signal {
			return _onConnectedSignal;
		}
		
		public function get onErrorSignal():Signal {
			return _onErrorSignal;
		}
		
		public function get error():PlayerIOError {
			return _error;
		}
		
		public function get connection():Connection {
			return _connection;
		}
	}
}
