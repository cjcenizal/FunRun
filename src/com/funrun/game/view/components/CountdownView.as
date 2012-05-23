package com.funrun.game.view.components {
	
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class CountdownView extends AbstractComponent {
		
		private var _countdownLabel:AbstractLabel;
		
		public function CountdownView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
			_countdownLabel = new AbstractLabel( this, 0, 0, "20", 110, 0xe0920b );
		}
		
		public function init():void {
			
		}
	}
}
