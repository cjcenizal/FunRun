package com.funrun.services
{
	import org.osflash.signals.Signal;
	
	import playerio.Client;
	import playerio.Connection;
	import playerio.PlayerIOError;

	public class PlayerioMultiplayerService
	{
		private var _connection:Connection;
		private var _error:PlayerIOError;
		private var _onConnectedSignal:Signal;
		private var _onErrorSignal:Signal;
		
		public function PlayerioMultiplayerService()
		{
		}
		
		public function connect( client:Client, roomType:String, userJoinData:Object ):void {
			//Set developmentsever (Comment out to connect to your server online)
			//client.multiplayer.developmentServer = "127.0.0.1:8184";
			
			var roomId:String = null; // A null roomId uses a random one.
			var visibleToLobby:Boolean = true; // Should the room be visible in the lobby?
			var roomData:Object = {}; // Room data. This data is returned to lobby list. Variables can be modifed on the server.
			
			client.multiplayer.createJoinRoom(
				roomId,
				roomType,
				visibleToLobby,
				roomData,
				userJoinData,
				onRoomJoinSuccess,
				onError
			);
		}
		
		private function onRoomJoinSuccess( connection:Connection ):void {
			_connection = connection;
			_onConnectedSignal.dispatch();
		}
		
		private function onError( error:PlayerIOError ):void {
			_error = error;
			_onErrorSignal.dispatch();
		}
		
		public function get connection():Connection {
			return _connection;
		}
	}
}