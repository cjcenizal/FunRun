package com.cenizal.utils
{
	import flash.display.DisplayObject;

	public class Center
	{
		public static function both( thisObj:DisplayObject, ontoThat:DisplayObject ):void {
			horizontal( thisObj, ontoThat );
			vertical( thisObj, ontoThat );
		}
		
		public static function horizontal( thisObj:DisplayObject, ontoThat:DisplayObject ):void {
			thisObj.x = ( ontoThat.width - thisObj.width ) * .5;
			//if ( thisObj.parent != ontoThat ) thisObj.x += ontoThat.x;
		}
		
		public static function vertical( thisObj:DisplayObject, ontoThat:DisplayObject ):void {
			thisObj.y = ( ontoThat.height - thisObj.height ) * .5;
			//if ( thisObj.parent != ontoThat ) thisObj.y += ontoThat.y;
		}
	}
}