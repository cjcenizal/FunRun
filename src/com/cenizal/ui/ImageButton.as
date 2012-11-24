package com.cenizal.ui
{
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class ImageButton extends AbstractButton
	{
		
		protected var _normalImage:Bitmap;
		protected var _hoverImage:Bitmap;
		
		public function ImageButton(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0, clickHandler:Function=null)
		{
			super(parent, x, y, clickHandler);
			this.useHandCursor = this.mouseEnabled = true;
		}
		
		public function setImages( normal:Bitmap, hover:Bitmap, center:Boolean = true ):void {
			_normalImage = normal;
			_hoverImage = hover;
			addChild( _normalImage );
			addChild( _hoverImage );
			if ( center ) {
				_normalImage.x = _normalImage.width * -.5;
				_normalImage.y = _normalImage.height * -.5;
				_hoverImage.x = _hoverImage.width * -.5;
				_hoverImage.y = _hoverImage.height * -.5;
			} else {
				if ( _normalImage.scaleY == -1 ) _normalImage.y = _normalImage.height;
				if ( _hoverImage.scaleY == -1 ) _hoverImage.y = _hoverImage.height;
			}
			_hoverImage.alpha = 0;
			_width = normal.width;
			_height = normal.height;
		}
		
		override protected function onMouseOver( e:MouseEvent ):void {
			super.onMouseOver( e );
			TweenMax.to( _hoverImage, .25, { alpha: 1 } );
		}
		
		override protected function onMouseOut( e:MouseEvent ):void {
			super.onMouseOut( e );
			TweenMax.to( _hoverImage, .25, { alpha: 0 } );
		}
		
	}
}