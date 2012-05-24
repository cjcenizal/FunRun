package com.funrun.game {

	import com.cenizal.ui.AbstractComponent;
	import com.funrun.game.view.components.MainMenuView;
	
	import flash.display.DisplayObjectContainer;

	public class MainView extends AbstractComponent {
		
		private var _mainMenu:MainMenuView;
		
		public function MainView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}

		public function build():void {
			_mainMenu = new MainMenuView( this );
		}
	}
}
