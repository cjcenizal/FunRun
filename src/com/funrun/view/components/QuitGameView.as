package com.funrun.view.components {

	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.DummyButton;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class QuitGameView extends AbstractComponent {
		
		private var _button:DummyButton;
		public var onClick:Signal;
		
		public function QuitGameView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
			
		public function init():void {
			_button = new DummyButton( this, 0, 0, onClickButton, "Quit game", 0x0000ff, 12 );
			_button.draw();
			_button.x = stage.stageWidth - _button.width - 10;
			onClick = new Signal();
		}
		
		override public function destroy():void {
			super.destroy();
			_button.destroy();
			_button = null;
			onClick.removeAll();
			onClick = null;
		}
		
		private function onClickButton( e:MouseEvent ):void {
			onClick.dispatch();
		}
	}
}
