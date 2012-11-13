package com.cenizal.ui
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class ImageButton extends AbstractButton
	{
		
		private var _normalImage:Bitmap;
		private var _hoverImage:Bitmap;
		private var _smallScale:Number = .98;
		
		public function ImageButton(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0, clickHandler:Function=null)
		{
			super(parent, x, y, clickHandler);
			this.useHandCursor = this.mouseEnabled = true;
		}
		
		public function setImages( normal:Bitmap, hover:Bitmap ):void {
			_normalImage = normal;
			_hoverImage = hover;
			addChild( _normalImage );
			addChild( _hoverImage );
			_normalImage.x = _normalImage.width * -.5;
			_normalImage.y = _normalImage.height * -.5;
			_hoverImage.x = _hoverImage.width * -.5;
			_hoverImage.y = _hoverImage.height * -.5;
			this.scaleX = this.scaleY = this.scaleZ = _smallScale;
			_hoverImage.alpha = 0;
		}
		
		override protected function onMouseOver( e:MouseEvent ):void {
			super.onMouseOver( e );
			TweenMax.to( _hoverImage, .25, { alpha: 1 } );
			TweenMax.to( this, .5, { scaleX: 1, scaleY: 1, scaleZ: 1, ease: Elastic.easeOut } );
		}
		
		override protected function onMouseOut( e:MouseEvent ):void {
			super.onMouseOut( e );
			TweenMax.to( _hoverImage, .25, { alpha: 0 } );
			TweenMax.to( this, .5, { scaleX: _smallScale, scaleY: _smallScale, scaleZ: _smallScale, ease: Elastic.easeOut } );
		}
		
	}
}