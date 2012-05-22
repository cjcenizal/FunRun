package com.funrun.modulemanager.services {
	
	import org.osflash.signals.Signal;
	
	import playerio.Client;
	import playerio.PlayerIOError;

	public interface IPlayerioConnectionService {
		
		function connect():void;
		function get client():Client;
		function get userId():String;
		function get isConnected():Boolean;
		function get onConnectedSignal():Signal;
		function get onErrorSignal():Signal;
		function get error():PlayerIOError;
	}
}
