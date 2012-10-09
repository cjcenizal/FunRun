package com.funrun.view.components {

	import com.cenizal.ui.AbstractButton;
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.ui.DummyButton;
	import com.cenizal.utils.Center;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class MainMenuView extends AbstractComponent {
		
		[Embed (source="external/embed/images/logo.jpg" )]
		private var Logo:Class;
		
		private var _logo:Bitmap;
		private var _multiplayerButton:DummyButton;
		private var _singlePlayerButton:DummyButton;
		private var _loginStatus:LoginStatusView;
		
		public var onMultiplayerClickSignal:Signal;
		public var onSinglePlayerClickSignal:Signal;
		
		public function MainMenuView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
		
		public function init():void {
			onMultiplayerClickSignal = new Signal();
			onSinglePlayerClickSignal = new Signal();
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
			
			// Multiplayer game button.
			_multiplayerButton = new DummyButton( this, 0, _logo.y + _logo.height + 80, onMultiplayerClick, "Multiplayer game", 0xaaaaaa );
			_multiplayerButton.draw();
			Center.horizontal( _multiplayerButton, stage );
			
			// Single player game button.
			_singlePlayerButton = new DummyButton( this, 0, _multiplayerButton.y + _multiplayerButton.height + 20, onSinglePlayerClick, "Single player game", 0xaaaaaa );
			_singlePlayerButton.draw();
			Center.horizontal( _singlePlayerButton, stage );
			
			// Login status.
			_loginStatus = new LoginStatusView( this );
			_loginStatus.draw();
		}
		
		private function onMultiplayerClick( e:MouseEvent ):void {
			onMultiplayerClickSignal.dispatch();
		}
		
		private function onSinglePlayerClick( e:MouseEvent ):void {
			onSinglePlayerClickSignal.dispatch();
		}
		
		public function set optionsEnabled( enabled:Boolean ):void {
			if ( enabled ) {
				_logo.alpha = 1;
				_multiplayerButton.visible = true;
			} else {
				_logo.alpha = .2;
				_multiplayerButton.visible = false;
			}
		}
	}
}
