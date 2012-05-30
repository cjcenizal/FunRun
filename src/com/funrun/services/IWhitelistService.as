package com.funrun.services
{
	public interface IWhitelistService
	{
		function add( id:Number ):void;
		function passes( id:String ):Boolean;
	}
}