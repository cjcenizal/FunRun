package com.funrun.modulemanager.controller.events {
	
	import flash.events.Event;

	public class LoginRequest extends Event {

		public static const LOGIN_REQUESTED:String = "LoginRequest.LOGIN_REQUESTED";

		public function LoginRequest( type:String ) {
			super( type );
		}
	}
}
