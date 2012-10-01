package com.funrun.view.components {

	import com.cenizal.ui.AbstractComponent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class MainView extends AbstractComponent {
		
		private const MAIN:String = "main";
		private const LOBBY:String = "lobby";
		private const GAME:String = "game";
		
		private var _views:Object;
		private var _popups:PopupsView;
		
		public function MainView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}

		public function init():void {
			_views = {};
			_views[ MAIN ] = new MainMenuView( this );
			_views[ LOBBY ] = new LobbyView( this );
			_views[ GAME ] = new GameView( this );
			_popups = new PopupsView( this );
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
			for ( var key:String in _views ) {
				( _views[ key ] as Sprite ).visible = ( key == id );
			}
		}
	}
}
