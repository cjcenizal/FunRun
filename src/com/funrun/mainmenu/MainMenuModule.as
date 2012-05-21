package com.funrun.mainmenu {
	
	import com.funrun.game.view.components.TrackView;
	
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	
	public class MainMenuModule extends ModuleContextView {
		
		private var _isRunning:Boolean = false;
		private var _track:TrackView;
		
		public function MainMenuModule() {
			super();
			context = new MainMenuContext( this );
			visible = false;
		}
		
		public function build():void {
			var g:Graphics = this.graphics;
			g.beginFill( 0xff0000 );
			g.drawCircle( 0, 0, 200 );
			g.endFill();
		}
		
		private function onClick( e:MouseEvent ):void {
			dispatchEvent( new Event( "CLICK" ) );
		}
		
		public function startRunning():void {
			if ( !_isRunning ) {
				this.visible = true;
				_isRunning = true;
				addEventListener( MouseEvent.CLICK, onClick );
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
