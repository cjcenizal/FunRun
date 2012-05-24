package com.cenizal.utils
{
	public class Numbers
	{
		public static function addCommasTo( number:String ):String {
			return number.replace( /\d{1,3}(?=(\d{3})+(?!\d))/g, "$&," );
		}
	}
}