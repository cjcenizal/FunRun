package com.funrun.mainmenu {
	
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.ui.DummyButton;
	import com.funrun.game.view.components.TrackView;
	
	import flash.display.Graphics;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	
	public class MainMenuModule extends ModuleContextView {
		
		private var _isRunning:Boolean = false;
		private var _track:TrackView;
		private var _startGameButton:DummyButton;
		
		public function MainMenuModule() {
			super();
			context = new MainMenuContext( this );
			visible = false;
		}
		
		public function build():void {
			_startGameButton = new DummyButton( this, 0, 0, onClick, "Start game", 0xaaaaaa );
		}
		
		private function onClick( e:MouseEvent ):void {
			dispatchEvent( new Event( "CLICK" ) );
		}
		
		public function startRunning():void {
			if ( !_isRunning ) {
				this.visible = true;
				_isRunning = true;
				stage.quality = StageQuality.BEST;
			}
		}
		
		public function stopRunning():void {
			this.visible = false;
			_isRunning = false;
		}
		
		public function get isRunning():Boolean {
			return _isRunning;
		}
	}
}
