package com.funrun.services
{
	import org.osflash.signals.Signal;

	public interface IWhitelistService
	{
		function add( id:Number ):void;
		function passes( id:String ):Boolean;
		function load():void;
		function get onLoadedSignal():Signal;
		function get isLoaded():Boolean;
	}
}