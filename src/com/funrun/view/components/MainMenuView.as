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
		private var _joinLobbyButton:DummyButton;
		//private var _instructionsLabel:AbstractLabel;
		private var _loginStatus:LoginStatusView;
		
		public var onJoinLobbyClick:Signal;
		
		public function MainMenuView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
		
		public function init():void {
			onJoinLobbyClick = new Signal();
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
			_joinLobbyButton = new DummyButton( this, 0, _logo.y + _logo.height + 40, onClick, "Join lobby", 0xaaaaaa );
			_joinLobbyButton.draw();
			Center.horizontal( _joinLobbyButton, stage );
			
			/*
			// Instructions.
			var instructionText:String = "Use arrow keys to move left and right, duck, and jump."
			_instructionsLabel = new AbstractLabel( this, 0, _joinLobbyButton.y + _joinLobbyButton.height + 40, instructionText, 14 );
			_instructionsLabel.draw();
			Center.horizontal( _instructionsLabel, stage );
			*/
			// Login status.
			_loginStatus = new LoginStatusView( this );
			_loginStatus.draw();
		}
		
		private function onClick( e:MouseEvent ):void {
			onJoinLobbyClick.dispatch();
		}
		
		public function set optionsEnabled( enabled:Boolean ):void {
			if ( enabled ) {
				_logo.alpha = 1;
				_joinLobbyButton.visible = true;
			} else {
				_logo.alpha = .2;
				_joinLobbyButton.visible = false;
			}
		}
	}
}
