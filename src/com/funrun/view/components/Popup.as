package com.funrun.view.components {
	
	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	
	public class Popup extends AbstractComponent {

		public function Popup( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0, width:Number = 100, height:Number = 100 ) {
			_width = width;
			_height = height;
			super( parent, x, y );
		}
		
		override public function draw():void {
			super.draw();
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle( 1, 0x666666 );
			g.beginFill( 0xeeeeee );
			g.drawRect( 0, 0, _width, _height );
			g.endFill();
		}
	}
}
