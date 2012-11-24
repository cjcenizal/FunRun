package com.funrun.view.components.ui
{
	import com.cenizal.ui.ImageButton;
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class FunButton extends ImageButton
	{
		
		protected var _normalScale:Number = 1;
		protected var _hoverScale:Number = .98;
		
		public function FunButton(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0, clickHandler:Function=null)
		{
			super(parent, x, y, clickHandler);
		}
		
		override public function setImages( normal:Bitmap, hover:Bitmap, center:Boolean = true ):void {
			super.setImages( normal, hover, center );
			this.scaleX = this.scaleY = this.scaleZ = _normalScale;
		}
		
		override protected function onMouseOver( e:MouseEvent ):void {
			super.onMouseOver( e );
			TweenMax.to( this, .5, { scaleX: _hoverScale, scaleY: _hoverScale, scaleZ: _hoverScale, ease: Elastic.easeOut } );
		}
		
		override protected function onMouseOut( e:MouseEvent ):void {
			super.onMouseOut( e );
			TweenMax.to( this, .5, { scaleX: _normalScale, scaleY: _normalScale, scaleZ: _normalScale, ease: Elastic.easeOut } );
		}
	}
}