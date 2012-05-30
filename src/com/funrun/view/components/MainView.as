package com.funrun.view.components {

	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.DisplayObjectContainer;

	public class MainView extends AbstractComponent {
		
		private var _mainMenu:MainMenuView;
		private var _game:GameView;
		private var _popups:PopupsView;
		
		public function MainView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}

		public function init():void {
			_mainMenu = new MainMenuView( this );
			_game = new GameView( this );
			_popups = new PopupsView( this );
		}
		
		public function hideAll():void {
			_mainMenu.visible = false;
			_game.visible = false;
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
