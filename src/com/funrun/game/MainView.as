package com.funrun.game {

	import com.cenizal.ui.AbstractComponent;
	import com.funrun.game.view.components.GameView;
	import com.funrun.game.view.components.MainMenuView;
	
	import flash.display.DisplayObjectContainer;

	public class MainView extends AbstractComponent {
		
		private var _mainMenu:MainMenuView;
		private var _game:GameView;
		
		public function MainView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}

		public function build():void {
			_mainMenu = new MainMenuView( this );
			_game = new GameView( this );
		}
		
		public function showGame():void {
			_mainMenu.visible = false;
			_game.visible = true;
		}
		
		public function showMainMenu():void {
			_mainMenu.visible = true;
			_game.visible = false;
		}
	}
}
