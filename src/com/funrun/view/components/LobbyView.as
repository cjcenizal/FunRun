package com.funrun.view.components {
	
	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	
	public class LobbyView extends AbstractComponent {
		
		
		public function LobbyView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
			visible = false;
		}
		
		public function init():void {
			
			// Background.
			var g:Graphics = this.graphics;
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			
		}
	}
}
