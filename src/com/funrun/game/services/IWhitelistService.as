package com.funrun.game.services
{
	public interface IWhitelistService
	{
		function add( id:String ):void;
		function passes( id:String ):Boolean;
	}
}