package com.funrun.services {
	
	import org.osflash.signals.Signal;
	
	import playerio.Client;
	
	public interface IWhitelistService {
		function isIdInTable( id:String, dbName:String, client:Client ):void;
		function get onPassSignal():Signal;
		function get onFailSignal():Signal;
		function get onErrorSignal():Signal;
		function get error():Error;
	}
}
