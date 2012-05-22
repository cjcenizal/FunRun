package com.funrun.modulemanager.services {
	
	import flash.display.Stage;
	
	import org.osflash.signals.Signal;
	
	import playerio.Client;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;
	
	public class PlayerioFacebookConnectionService implements IPlayerioConnectionService {

		private var _error:PlayerIOError;
		private var _onConnectedSignal:Signal;
		private var _onErrorSignal:Signal;
		private var _stage:Stage;
		private var _fbAccessToken:Object;
		private var _gameId:String;
		private var _partnerId:String;
		private var _client:Client;
		private var _userId:String;
		
		public function PlayerioFacebookConnectionService( stage:Stage, fbAccessToken:Object, gameId:String, partnerId:String ) {
			_stage = stage;
			_fbAccessToken = fbAccessToken;
			_gameId = gameId;
			_partnerId = partnerId;
			_onConnectedSignal = new Signal();
			_onErrorSignal = new Signal();
		}

		public function connect():void {
			// If we are already logged into Facebook, then we can move a little more quickly.
			if ( _fbAccessToken ) {
				PlayerIO.quickConnect.facebookOAuthConnect(
					_stage,
					_gameId,
					_fbAccessToken,
					_partnerId,
					onFacebookOAuthConnectSuccess,
					onError
				);
			} else {
				// If not, then we need to get the user to log into FB first.
				PlayerIO.quickConnect.facebookOAuthConnectPopup(
					_stage,
					_gameId,
					"_blank",
					[],
					_partnerId,
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
			
			/*
			if ( !_whitelist || _whitelist.has( mId ) ) {
				_playerIOClient = mClient;
				_fbid = ( _useHardCodedId && _hardCodedId ) ? _hardCodedId : mId;
				Tracking.identifyUser( _fbid );
				
				// Init the AS3 Facebook Graph API.
				FB.init( { access_token: mAccesToken, app_id: APP_ID, debug: true } );
				
				// Get user data.
				FB.api( '/me', function( response:* ):void {
					_me = response;
					_gender = _me[ "gender" ];
					_name = _me[ "name" ];
					_firstName = _me[ "first_name" ];
					// Do a Facebook FQL query for those of my friends whom have the application installed.
					//getFriends( mClient );
					onComplete();
				} );
			} else {
				// Not a beta tester.
			}
			*/
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
	}
}
