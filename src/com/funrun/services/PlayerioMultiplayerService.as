package com.funrun.services {

	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	import playerio.Client;
	import playerio.Connection;
	import playerio.PlayerIOError;

	public class PlayerioMultiplayerService {
		
		private var _connection:Connection;
		private var _error:PlayerIOError;
		private var _onConnectedSignal:Signal;
		private var _onErrorSignal:Signal;
		private var _onServerDisconnectSignal:Signal;
		private var _isConnected:Boolean = false;
		private var _messageHandlers:Object = {};
		public var roomId:int = -1;

		public function PlayerioMultiplayerService() {
			_onConnectedSignal = new Signal();
			_onErrorSignal = new Signal();
			_onServerDisconnectSignal = new Signal();
		}

		public function connect( client:Client, roomType:String, userJoinData:Object = null, roomId:String = "$service-room$" ):void {
			userJoinData = userJoinData || {};
			var visibleToLobby:Boolean = true; // Should the room be visible in a listRooms() call?
			var roomData:Object = {}; // Room data. This data is returned to lobby list. Variables can be modifed on the server.
			client.multiplayer.createJoinRoom( roomId, roomType, visibleToLobby, roomData, userJoinData, onRoomJoinSuccess, onError );
		}

		public function disconnect():void {
			_connection.disconnect();
			_connection.removeDisconnectHandler( onServerDisconnect );
			for ( var key:String in _messageHandlers ) {
				for ( var fn:String in _messageHandlers[ key ] ) {
					_connection.removeMessageHandler( key, _messageHandlers[ key ][ fn ] );
				}
				delete _messageHandlers[ key ];
			}
			_messageHandlers = {};
			_connection = null;
			_error = null;
			_isConnected = false;
			_onConnectedSignal.removeAll();
			_onErrorSignal.removeAll();
			_onServerDisconnectSignal.removeAll();
			roomId = -1;
		}
		
		private function onRoomJoinSuccess( connection:Connection ):void {
			_connection = connection;
			_connection.addDisconnectHandler( onServerDisconnect );
			_isConnected = true;
			_onConnectedSignal.dispatch();
		}

		private function onError( error:PlayerIOError ):void {
			_error = error;
			_onErrorSignal.dispatch();
		}

		private function onServerDisconnect():void {
			_onServerDisconnectSignal.dispatch();
		}
		
		public function addMessageHandler( type:String, handler:Function ):void {
			_connection.addMessageHandler( type, handler );
			if ( !_messageHandlers[ type ] ) {
				_messageHandlers[ type ] = new Dictionary();
			}
			( _messageHandlers[ type ] as Dictionary )[ handler ] = handler;
		}
		
		public function removeMessageHandler( type:String, handler:Function ):void {
			_connection.removeMessageHandler( type, handler );
			if ( _messageHandlers[ type ] ) {
				delete _messageHandlers[ type ][ handler ];
			}
		}
		
		public function send( type:String, ...args ):void {
			_connection.send( type, 100 );
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
		
		public function get onServerDisconnectSignal():Signal {
			return _onServerDisconnectSignal;
		}
		
		public function get error():PlayerIOError {
			return _error;
		}
	}
}
