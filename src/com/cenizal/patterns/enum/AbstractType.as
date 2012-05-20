package com.cenizal.patterns.enum
{
	public class AbstractType
	{
		/**
		 * Used by EnumUtils to assign a name to each enum value.
		 */
		public var type:String;
		
		public function toString():String {
			return type;
		}
	}
}