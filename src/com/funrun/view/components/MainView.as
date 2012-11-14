package com.funrun.view.components {

	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class MainView extends AbstractComponent {
		
		private const MAIN:String = "main";
		private const LOBBY:String = "lobby";
		private const GAME:String = "game";
		
		private var _screenViews:Object;
		private var _popupsView:PopupsView;
		private var _loadingView:LoadingView;
		
		public function MainView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}

		public function init():void {
			_screenViews = {};
			_screenViews[ MAIN ] = new MainMenuView( this );
			_screenViews[ LOBBY ] = new LobbyView( this );
			_screenViews[ GAME ] = new GameView( this );
			_popupsView = new PopupsView( this );
			_loadingView = new LoadingView( this );
		}
		
		public function hideAll():void {
			show( null );
		}
		
		public function showGame():void {
			show( GAME );
		}
		
		public function showLobby():void {
			show( LOBBY );
		}
		
		public function showMainMenu():void {
			show( MAIN );
		}
		
		private function show( id:String ):void {
			for ( var key:String in _screenViews ) {
				( _screenViews[ key ] as Sprite ).visible = ( key == id );
			}
		}
	}
}
