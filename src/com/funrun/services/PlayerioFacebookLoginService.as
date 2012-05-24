package com.funrun.services {
	
	import flash.display.Stage;
	
	import org.osflash.signals.Signal;
	
	import playerio.Client;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;
	
	public class PlayerioFacebookLoginService implements IPlayerioLoginService {

		private var _error:PlayerIOError;
		private var _onConnectedSignal:Signal;
		private var _onErrorSignal:Signal;
		private var _client:Client;
		private var _userId:String;
		private var _fbAccessToken:String;
		
		public function PlayerioFacebookLoginService(  ) {
			_onConnectedSignal = new Signal();
			_onErrorSignal = new Signal();
		}

		public function connect( stage:Stage, fbAccessToken:String, gameId:String, partnerId:String ):void {			
			// If we are already logged into Facebook, then we can move a little more quickly.
			if ( fbAccessToken ) {
				_fbAccessToken = fbAccessToken;
				PlayerIO.quickConnect.facebookOAuthConnect(
					stage,
					gameId,
					fbAccessToken,
					partnerId,
					onFacebookOAuthConnectSuccess,
					onError
				);
			} else {
				// If not, then we need to get the user to log into FB first.
				PlayerIO.quickConnect.facebookOAuthConnectPopup(
					stage,
					gameId,
					"_blank",
					[],
					partnerId,
					onFacebookOAuthConnectPopupSuccess,
					onError
				);
			}
		}

		private function onFacebookOAuthConnectSuccess( client:Client, userId:String = "" ):void {
			_client = client;
			_userId = userId;
			_onConnectedSignal.dispatch();
		}
		
		private function onFacebookOAuthConnectPopupSuccess( client:Client, fbAccessToken:String, userId:String = "" ):void {
			_client = client;
			_fbAccessToken = fbAccessToken;
			_userId = userId;
			_onConnectedSignal.dispatch();
		}
		
		private function onError( error:PlayerIOError ):void {
			_error = error;
			_onErrorSignal.dispatch();
		}
		
		public function get userId():String {
			return _userId;
		}

		public function get isConnected():Boolean {
			return true;
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
		
		public function get client():Client {
			return _client;
		}
		
		public function get fbAccessToken():String {
			return _fbAccessToken;
		}
	}
}
