package com.funrun.view.components.ui
{
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	
	public class TextNote extends AbstractComponent
	{
		
		private var _text:AbstractLabel;
		private var _bg:Shape;
		
		public function TextNote(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
			_bg = new Shape();
			addChild( _bg );
			_text = new AbstractLabel( this, 0, 0, null, 14, 0xff6700 );
		}
		
		public function set text( val:String ):void {
			_text.text = val;
			_text.draw();
			var margin:Number = 8;
			var g:Graphics = _bg.graphics;
			g.clear();
			g.beginFill( 0xffffff );
			g.drawRoundRect( -margin, -margin, _text.width + margin * 2, _text.height + margin * 2, 10 );
			g.endFill();
			_width = _text.width;
			_height = _text.height;
		}
	}
}