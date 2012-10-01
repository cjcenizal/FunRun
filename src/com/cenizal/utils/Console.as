package com.cenizal.utils
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.system.System;

	public class Console extends Sprite
	{
		
		private var _isOpen:Boolean = false;
		
		private var _text:TextField;
		
		public function Console()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			this.visible = _isOpen;
			_text = new TextField();
			addChild( _text );
			_text.textColor = 0xffffff;
			_text.selectable = true;
			_text.wordWrap = _text.multiline = true;
			_text.x = _text.y = 10;
		}
		
		private function onAddedToStage( e:Event ):void {
			var g:Graphics = this.graphics;
			g.beginFill( 0x000000, .9 );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			_text.width = stage.stageWidth - stage.x * 2;
			_text.height = stage.stageHeight;
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			if ( e.keyCode == 192 ) { // Tilde
				if ( _isOpen ) {
					close();
				} else {
					open();
				}
				this.visible = _isOpen;
			}
		}
		
		private function open():void {
			_isOpen = true;
			System.setClipboard( _text.text );
		}
		
		private function close():void {
			_isOpen = false;
		}
		
		public function log( source:*, message:String ):void {
			print( source, message );
		}
		
		private function print( source:*, message:String):void {
			_text.htmlText += source + ": " + message + "<br>";
		}
	}
}