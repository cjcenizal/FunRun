package com.cenizal.ui
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class Image extends AbstractComponent
	{
		private var _bitmap:Bitmap;
		
		public function Image( parent:DisplayObjectContainer, x:Number, y:Number, bitmap:Bitmap, isCentered:Boolean = false )
		{
			super( parent, x, y );
			_bitmap = bitmap;
			addChild( _bitmap );
			if ( isCentered ) {
				_bitmap.x = -_bitmap.width * .5;
				_bitmap.y = -_bitmap.height * .5;
			}
			_width = _bitmap.width;
			_height = _bitmap.height;
		}
	}
}