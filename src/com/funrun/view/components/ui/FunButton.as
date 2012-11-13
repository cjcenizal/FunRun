package com.funrun.view.components.ui
{
	import com.cenizal.ui.ImageButton;
	import com.greensock.easing.Elastic;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class FunButton extends ImageButton
	{
		
		protected var _smallScale:Number = .98;
		
		public function FunButton(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0, clickHandler:Function=null)
		{
			super(parent, x, y, clickHandler);
		}
		
		override public function setImages( normal:Bitmap, hover:Bitmap ):void {
			super.setImages( normal, hover );
			this.scaleX = this.scaleY = this.scaleZ = _smallScale;
		}
		
		override protected function onMouseOver( e:MouseEvent ):void {
			super.onMouseOver( e );
			TweenMax.to( this, .5, { scaleX: 1, scaleY: 1, scaleZ: 1, ease: Elastic.easeOut } );
		}
		
		override protected function onMouseOut( e:MouseEvent ):void {
			super.onMouseOut( e );
			TweenMax.to( this, .5, { scaleX: _smallScale, scaleY: _smallScale, scaleZ: _smallScale, ease: Elastic.easeOut } );
		}
	}
}