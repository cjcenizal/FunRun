package com.cenizal.ui {
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public class DummyButton extends AbstractButton {
		
		private var _label:AbstractLabel;
		
		public function DummyButton( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0, defaultHandler:Function = null, text:String = null, fontColor:uint = 0 ) {
			super( parent, x, y, defaultHandler );
			_label = new AbstractLabel( this, 0, 0, text, 24, fontColor );
		}
		
		override protected function onMouseOver( e:MouseEvent ):void {
			super.onMouseOver( e );
		}
		
		override protected function onMouseOut( e:MouseEvent ):void {
			super.onMouseOut( e );
		}
		
		override public function draw():void {
			super.draw();
			_label.draw();
			_width = _label.width;
			_height = _label.height;
		}
	}
}
