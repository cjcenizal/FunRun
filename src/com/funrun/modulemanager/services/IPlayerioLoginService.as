package com.funrun.modulemanager.services {
	
	import flash.display.Stage;
	
	import org.osflash.signals.Signal;
	
	import playerio.Client;
	import playerio.PlayerIOError;

	public interface IPlayerioLoginService {
		
		function connect( stage:Stage, fbAccessToken:String, gameId:String, partnerId:String ):void;
		function get client():Client;
		function get userId():String;
		function get isConnected():Boolean;
		function get onConnectedSignal():Signal;
		function get onErrorSignal():Signal;
		function get error():PlayerIOError;
		function get fbAccessToken():String;
	}
}
