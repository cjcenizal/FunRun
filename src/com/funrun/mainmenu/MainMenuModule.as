package com.funrun.mainmenu {
	
	import com.funrun.game.view.components.TrackView;
	
	import flash.display.Graphics;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	
	public class MainMenuModule extends ModuleContextView {
		
		private var _track:TrackView;
		
		public function MainMenuModule() {
			super();
			context = new MainMenuContext( this );
		}
		
		public function build():void {
			var g:Graphics = this.graphics;
			g.beginFill( 0xff0000 );
			g.drawCircle( 0, 0, 200 );
			g.endFill();
		}
		
		public function show():void {
			this.visible = true;
		}
		
		public function hide():void {
			this.visible = false;
		}
	}
}
