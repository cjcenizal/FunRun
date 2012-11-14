package com.funrun.view.components {

	import com.cenizal.ui.AbstractComponent;
	import com.funrun.view.components.ui.FunButton;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class MainMenuView extends AbstractComponent {
		
		[Embed (source="embed/home_bg.jpg" )]
		private var Background:Class;
		
		[Embed (source="embed/play_multiplayer_button.jpg" )]
		private var MultiplayerButton:Class;
		
		[Embed (source="embed/play_multiplayer_button_hover.jpg" )]
		private var MultiplayerButtonHover:Class;
		
		[Embed (source="embed/play_single_button.jpg" )]
		private var SingleButton:Class;
		
		[Embed (source="embed/play_single_button_hover.jpg" )]
		private var SingleButtonHover:Class;
		
		private var _bg:Bitmap;
		private var _multiplayerButton:FunButton;
		private var _singlePlayerButton:FunButton;
		
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
			_bg = new Background();
			addChild( _bg );
			
			// Multiplayer game button.
			_multiplayerButton = new FunButton( this, 350, 310, onMultiplayerClick );
			_multiplayerButton.setImages( new MultiplayerButton(), new MultiplayerButtonHover() );
			_multiplayerButton.rotation = -.8;
			
			// Single player game button.
			_singlePlayerButton = new FunButton( this, 420, 400, onSinglePlayerClick );
			_singlePlayerButton.setImages( new SingleButton(), new SingleButtonHover() );
			_singlePlayerButton.rotation = 1;
		}
		
		private function onMultiplayerClick( e:MouseEvent ):void {
			onMultiplayerClickSignal.dispatch();
		}
		
		private function onSinglePlayerClick( e:MouseEvent ):void {
			onSinglePlayerClickSignal.dispatch();
		}
	}
}
