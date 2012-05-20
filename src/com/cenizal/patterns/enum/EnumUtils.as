package com.cenizal.patterns.enum
{

	import flash.utils.describeType;
	
	/**
	 * @author Scott Bilas (http://scottbilas.com/blog/faking-enums-in-as3/).
	 */
	
	public class EnumUtils
	{

		/**
		 * Use reflection to add metadata to BaseState-extended enum classes.
		 */
		public static function initEnumConstants( inType:* ):void {
			var type:XML = describeType( inType );
			for each ( var constant:XML in type.constant ) {
				inType[ constant.@name ].type = constant.@name;
			}
		}
	}
}
