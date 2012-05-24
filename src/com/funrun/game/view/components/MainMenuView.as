package com.funrun.game.view.components {

	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.DummyButton;
	import com.cenizal.util.Center;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class MainMenuView extends AbstractComponent {
		
		[Embed (source="embed/logo.jpg" )]
		private var Logo:Class;
		
		private var _logo:Bitmap;
		private var _isRunning:Boolean = false;
		private var _startGameButton:DummyButton;
		private var _loginStatus:LoginStatusView;
		
		public var onStartGameButtonClick:Signal;
		
		public function MainMenuView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
			onStartGameButtonClick = new Signal();
		}
		
		public function build():void {
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( e:Event ):void {
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			// Background.
			var g:Graphics = this.graphics;
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			// Logo.
			_logo = new Logo();
			addChild( _logo );
			Center.horizontal( _logo, stage );
			_logo.y = 20;
			
			// Start game button.
			_startGameButton = new DummyButton( this, 0, _logo.y + _logo.height + 40, onClick, "Start game", 0xaaaaaa );
			_startGameButton.draw();
			Center.horizontal( _startGameButton, stage );
			
			// Login status.
			_loginStatus = new LoginStatusView( this );
			_loginStatus.draw();
			Center.horizontal( _loginStatus, stage );
			_loginStatus.y = height - _loginStatus.height;
		}
		
		private function onClick( e:MouseEvent ):void {
			onStartGameButtonClick.dispatch();
		}
		
		public function startRunning():void {
			if ( !_isRunning ) {
				this.visible = true;
				_isRunning = true;
			}
		}
		
		public function stopRunning():void {
			this.visible = false;
			_isRunning = false;
		}
		
		public function set optionsEnabled( enabled:Boolean ):void {
			if ( enabled ) {
				_logo.alpha = 1;
				_startGameButton.visible = true;
			} else {
				_logo.alpha = .2;
				_startGameButton.visible = false;
			}
		}
		
		public function get isRunning():Boolean {
			return _isRunning;
		}
	}
}
