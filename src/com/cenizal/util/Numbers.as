package com.cenizal.util
{
	public class Numbers
	{
		public static function addCommas( val:String ):String {
			return val.replace( /\d{1,3}(?=(\d{3})+(?!\d))/g, "$&," );
		}
	}
}