package com.cenizal.utils
{
	import flash.display.DisplayObject;

	public class Center
	{
		public static function both( thisObj:DisplayObject, ontoThat:DisplayObject ):void {
			horizontal( thisObj, ontoThat );
			vertical( thisObj, ontoThat );
		}
		
		public static function bothVals( thisObj:DisplayObject, width:Number, height:Number ):void {
			horizontalVal( thisObj, width );
			verticalVal( thisObj, height );
		}
		
		public static function horizontal( thisObj:DisplayObject, ontoThat:DisplayObject ):void {
			thisObj.x = ( ontoThat.width - thisObj.width ) * .5;
			//if ( thisObj.parent != ontoThat ) thisObj.x += ontoThat.x;
		}
		
		public static function vertical( thisObj:DisplayObject, ontoThat:DisplayObject ):void {
			thisObj.y = ( ontoThat.height - thisObj.height ) * .5;
			//if ( thisObj.parent != ontoThat ) thisObj.y += ontoThat.y;
		}
		
		public static function horizontalVal( thisObj:DisplayObject, width:Number ):void {
			thisObj.x = ( width - thisObj.width ) * .5;
			//if ( thisObj.parent != ontoThat ) thisObj.x += ontoThat.x;
		}
		
		public static function verticalVal( thisObj:DisplayObject, height:Number ):void {
			thisObj.y = ( height - thisObj.height ) * .5;
			//if ( thisObj.parent != ontoThat ) thisObj.y += ontoThat.y;
		}
	}
}